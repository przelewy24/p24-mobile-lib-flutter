package pl.przelewy24.p24_sdk.google_pay

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import pl.przelewy24.p24lib.google_pay.GooglePayActivity
import pl.przelewy24.p24lib.google_pay.GooglePayParams
import pl.przelewy24.p24lib.google_pay.GooglePayResult
import pl.przelewy24.p24lib.google_pay.GooglePayTransactionRegistrar


object GooglePayMethodHandler {
    
    const val GP_REQUEST_CODE = 222

    fun handle(call: MethodCall, result: MethodChannel.Result, binding: ActivityPluginBinding, binaryMessenger: BinaryMessenger) {

        binding.addActivityResultListener(activityResultListener(binding, result))

        val googlePayMap: HashMap<String, Any> = call.arguments as HashMap<String, Any>
        val googlePayParams: GooglePayParams = parseGooglePayMap(googlePayMap)
        val registrar: GooglePayTransactionRegistrar = getGooglePayRegistrar(binaryMessenger)

        startGooglePay(binding, googlePayParams, registrar)

    }

    private fun activityResultListener(binding: ActivityPluginBinding, result: MethodChannel.Result): PluginRegistry.ActivityResultListener {
        return object : PluginRegistry.ActivityResultListener {
            override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
                if (requestCode == GP_REQUEST_CODE) {
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
            val googlePayResult: GooglePayResult = GooglePayActivity.parseResult(data)
            if (googlePayResult.isCompleted) {
                setSuccessResult(result)
            } else {
                setErrorResult(googlePayResult, result)
            }
        } else {
            setCancelResult(result)
        }
    }

    private fun setSuccessResult(result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "success"
        ))
    }

    private fun setErrorResult(googlePayResult: GooglePayResult, result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "error",
            "payload" to googlePayResult.errorCode
        ))
    }

    private fun setCancelResult(result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "cancel"
        ))
    }

    private fun parseGooglePayMap(googlePayMap: HashMap<String, Any>): GooglePayParams {
        val merchantId = googlePayMap["merchantId"] as Int
        val amount = googlePayMap["amount"] as Int
        val currency = googlePayMap["currency"] as String
        val isSandbox = googlePayMap["isSandbox"] as Boolean

        return GooglePayParams.create(merchantId, amount, currency).setSandbox(isSandbox)
    }

    private fun getGooglePayRegistrar(binaryMessenger: BinaryMessenger): GooglePayTransactionRegistrar {
        return GooglePayRegistrarChannel(binaryMessenger)
    }

    private fun startGooglePay(binding: ActivityPluginBinding, googlePayParams: GooglePayParams, registrar: GooglePayTransactionRegistrar) {
        val intent: Intent = GooglePayActivity.getStartIntent(binding.activity, googlePayParams, registrar)
        binding.activity.startActivityForResult(intent, GP_REQUEST_CODE)
    }
}

