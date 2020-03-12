package pl.przelewy24.p24_sdk.transfer

import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import pl.przelewy24.p24lib.transfer.TransferActivity
import pl.przelewy24.p24lib.transfer.direct.TrnDirectParams

object TrnDirectIntentFactory: TransferIntentFactory {
    
    override fun create(call: MethodCall, context: Context): Intent {
        val args = call.arguments as HashMap<String, Any>
        val params = parseTrnDirectMap(args)
        return TransferActivity.getIntentForTrnDirect(context, params)
    }

    private fun parseTrnDirectMap(trnDirectMap: HashMap<String, Any>): TrnDirectParams {
        val isSandbox = trnDirectMap["isSandbox"] as Boolean
        val transactionParams = trnDirectMap["transactionParams"] as HashMap<String, Any>

        val params = TransactionParamsMapper.build(transactionParams)
        return TrnDirectParams.create(params).setSandbox(isSandbox)
    }

}