package pl.przelewy24.p24_sdk

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import pl.przelewy24.p24lib.settings.ExtraFeaturesConfig

class ExtraFeaturesConfigMethodCallsHandler: MethodChannel.MethodCallHandler  {
    
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "setRemoteConfigUrl" -> setRemoteConfigUrl(call, result)
            "enableExpressFeatures" -> enableExpressFeatures(call, result)
            "disableExpressFeatures" -> disableExpressFeatures(result)
        }
    }

    private fun setRemoteConfigUrl(call: MethodCall, result: MethodChannel.Result) {
        ExtraFeaturesConfig.setRemoteConfigUrl(call.arguments as String)
        result.success(1)
    }

    private fun enableExpressFeatures(call: MethodCall,  result: MethodChannel.Result) {
        ExtraFeaturesConfig.enableExpressFeatures(call.arguments as String)
        result.success(1)
    }

    private fun disableExpressFeatures(result: MethodChannel.Result) {
        ExtraFeaturesConfig.disableExpressFeatures()
        result.success(1)
    }

}