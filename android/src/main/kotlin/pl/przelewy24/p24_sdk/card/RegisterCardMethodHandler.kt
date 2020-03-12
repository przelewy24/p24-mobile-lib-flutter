package pl.przelewy24.p24_sdk.card

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import pl.przelewy24.p24lib.card.CardData
import pl.przelewy24.p24lib.card.RegisterCardActivity
import pl.przelewy24.p24lib.card.RegisterCardParams
import pl.przelewy24.p24lib.card.RegisterCardResult

object RegisterCardMethodHandler {
    
    const val CARD_REGISTER_REQUEST_CODE = 333

    fun handle(call: MethodCall, result: MethodChannel.Result, binding: ActivityPluginBinding) {

        binding.addActivityResultListener(activityResultListener(binding, result))

        val registerCardMap: HashMap<String, Any> = call.arguments as HashMap<String, Any>
        val registerCardParams: RegisterCardParams = parseRegisterCardMap(registerCardMap)

        startRegisterCard(binding, registerCardParams)

    }

    private fun activityResultListener(binding: ActivityPluginBinding, result: MethodChannel.Result): PluginRegistry.ActivityResultListener {
        return object : PluginRegistry.ActivityResultListener {
            override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
                if (requestCode == CARD_REGISTER_REQUEST_CODE) {
                    binding.removeActivityResultListener(this)
                    handleSdkResult(resultCode, data, result)
                    return true
                }
                return false
            }
        }
    }

    private fun handleSdkResult(resultCode: Int, data: Intent?, result: MethodChannel.Result) {
        if (resultCode == Activity.RESULT_OK) {
            val registerCardResult: RegisterCardResult = RegisterCardActivity.parseResult(data)
            if (registerCardResult.isError) {
                setErrorResult(registerCardResult, result)
            } else {
                setSuccessResult(registerCardResult, result)
            }
        } else {
            setCancelResult(result)
        }
    }

    private fun setSuccessResult(cardRegisterResult: RegisterCardResult, result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "success",
            "payload" to cardRegisterResult.cardToken
        ))
    }

    private fun setErrorResult(cardRegisterResult: RegisterCardResult, result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "error",
            "payload" to cardRegisterResult.errorCode
        ))
    }

    private fun setCancelResult(result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "cancel"
        ))
    }

    private fun parseCardDataMap(cardDataMap: HashMap<String, Any>): CardData {
        val number = cardDataMap["number"] as String
        val expiryMonth = cardDataMap["expiryMonth"] as Int? ?: 0
        val expiryYear = cardDataMap["expiryYear"] as Int? ?: 0
        val cvv = cardDataMap["cvv"] as String

        return CardData(number, expiryMonth, expiryYear, cvv)
    }

    private fun parseRegisterCardMap(registerCardMap: HashMap<String, Any>): RegisterCardParams {
        val url = registerCardMap["url"] as String
        val cardDataMap = registerCardMap["cardData"] as HashMap<String, Any>
        val card: CardData = parseCardDataMap(cardDataMap)
        return RegisterCardParams.createPrefilled(url, card)
    }

    private fun startRegisterCard(binding: ActivityPluginBinding, registerCardParams: RegisterCardParams) {
        val intent: Intent = RegisterCardActivity.getStartIntent(binding.activity, registerCardParams)
        binding.activity.startActivityForResult(intent, CARD_REGISTER_REQUEST_CODE)
    }
}