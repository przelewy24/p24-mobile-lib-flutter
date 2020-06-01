package pl.przelewy24.p24_sdk

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import pl.przelewy24.p24lib.settings.SdkConfig

class SdkConfigMethodCallsHandler: MethodChannel.MethodCallHandler  {
  
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "setCertificatePinningEnabled" -> setCertificatePinningEnabled(call, result)
            "setFinishOnBackButtonEnabled" -> setFinishOnBackButtonEnabled(call, result)
            "getCertificatePinningEnabled" -> getCertificatePinningEnabled(result)
            "getFinishOnBackButtonEnabled" -> getFinishOnBackButtonEnabled(result)
        }
    }

    private fun setCertificatePinningEnabled(call: MethodCall, result: MethodChannel.Result) {
        SdkConfig.setCertificatePinningEnabled(call.arguments as Boolean)
        result.success(1)
    }

    private fun setFinishOnBackButtonEnabled(call: MethodCall, result: MethodChannel.Result) {
        SdkConfig.setFinishOnBackButtonEnabled(call.arguments as Boolean)
        result.success(1)
    }

    private fun getCertificatePinningEnabled(result: MethodChannel.Result) {
        result.success(SdkConfig.isCertificatePinningEnabled())
    }

    private fun getFinishOnBackButtonEnabled(result: MethodChannel.Result) {
        result.success(SdkConfig.isFinishOnBackButtonEnabled())
    }

}
