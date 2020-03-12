package pl.przelewy24.p24_sdk.transfer

import android.app.Activity
import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import pl.przelewy24.p24lib.transfer.TransferActivity
import pl.przelewy24.p24lib.transfer.TransferResult

object TransferMethodHandler {

    const val TRANSFER_REQUEST_CODE = 111

    fun handle(call: MethodCall, result: MethodChannel.Result, binding: ActivityPluginBinding, intentFactory: TransferIntentFactory) {
        binding.addActivityResultListener(activityResultListener(result, binding))
        val intent: Intent = intentFactory.create(call, binding.activity)
        binding.activity.startActivityForResult(intent, TRANSFER_REQUEST_CODE)
    }

    private fun activityResultListener(result: MethodChannel.Result, binding: ActivityPluginBinding): PluginRegistry.ActivityResultListener {
        return object : PluginRegistry.ActivityResultListener {
            override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
                if (requestCode == TRANSFER_REQUEST_CODE) {
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
            val transferResult: TransferResult = TransferActivity.parseResult(data)
            if (transferResult.isSuccess) {
                setSuccessResult(result)
            } else {
                setErrorResult(transferResult, result)
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

    private fun setErrorResult(transferResult: TransferResult, result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "error",
            "payload" to transferResult.errorCode
        ))
    }

    private fun setCancelResult(result: MethodChannel.Result) {
        result.success(mapOf(
            "status" to "cancel"
        ))
    }



}

interface TransferIntentFactory {

    fun create(call: MethodCall, context: Context) : Intent

}