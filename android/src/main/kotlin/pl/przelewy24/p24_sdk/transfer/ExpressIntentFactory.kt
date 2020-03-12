package pl.przelewy24.p24_sdk.transfer

import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import pl.przelewy24.p24lib.transfer.TransferActivity
import pl.przelewy24.p24lib.transfer.express.ExpressParams

object ExpressIntentFactory: TransferIntentFactory {
    
    override fun create(call: MethodCall, context: Context): Intent {
        val args = call.arguments as HashMap<String, Any>
        val params = parseExpressMap(args)
        return TransferActivity.getIntentForExpress(context, params)
    }

    private fun parseExpressMap(expressMap: HashMap<String, Any>): ExpressParams {
        val url = expressMap["url"] as String
        return ExpressParams.create(url)
    }

}
