package pl.przelewy24.p24_sdk

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import pl.przelewy24.p24_sdk.card.RegisterCardMethodHandler
import pl.przelewy24.p24_sdk.google_pay.GooglePayMethodHandler
import pl.przelewy24.p24_sdk.transfer.*

class MethodCallsHandler(private val binding: ActivityPluginBinding, private val binaryMessenger: BinaryMessenger): MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        try {
            when(call.method){
                "trnRequest" -> TransferMethodHandler.handle(call, result, binding, TrnRequestIntentFactory)
                "trnDirect" -> TransferMethodHandler.handle(call, result, binding, TrnDirectIntentFactory)
                "transferExpress" -> TransferMethodHandler.handle(call, result, binding, ExpressIntentFactory)
                "transferPassage" ->TransferMethodHandler.handle(call, result, binding, PassageIntentFactory)
                "googlePay" -> GooglePayMethodHandler.handle(call, result, binding, binaryMessenger)
                "registerCard" -> RegisterCardMethodHandler.handle(call, result, binding)
            }
        } catch (t: Throwable) {
            throw Error(t)
        }
        
    }

}