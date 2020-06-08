package pl.przelewy24.p24_sdk

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import pl.przelewy24.p24lib.util.P24SdkVersion

class P24SdkVersionCallsHandler: MethodChannel.MethodCallHandler {

	override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
		when(call.method){
			"getP24SdkVersion" -> result.success(P24SdkVersion.value())
		}
	}

}
