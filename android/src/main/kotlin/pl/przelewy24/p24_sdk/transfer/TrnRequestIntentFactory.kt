package pl.przelewy24.p24_sdk.transfer

import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import pl.przelewy24.p24lib.transfer.TransferActivity
import pl.przelewy24.p24lib.transfer.request.TrnRequestParams

object TrnRequestIntentFactory : TransferIntentFactory {
    
    override fun create(call: MethodCall, context: Context) : Intent {
        val args = call.arguments as HashMap<String, Any>
        val token = args["token"] as String
        val isSandbox = args["isSandbox"] as Boolean
        val params = TrnRequestParams.create(token)
                .setSandbox(isSandbox)
        
        return TransferActivity.getIntentForTrnRequest(context, params)
    }

}