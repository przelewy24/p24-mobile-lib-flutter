package pl.przelewy24.p24_sdk.transfer

import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import pl.przelewy24.p24lib.transfer.TransferActivity
import pl.przelewy24.p24lib.transfer.direct.TrnDirectParams

object PassageIntentFactory: TransferIntentFactory {
    
    override fun create(call: MethodCall, context: Context): Intent {
        val args = call.arguments as HashMap<String, Any>
        val parsePassageMap = parsePassageMap(args)
        return TransferActivity.getIntentForTrnDirect(context, parsePassageMap)

    }

    private fun parsePassageMap(passageMap: HashMap<String, Any>): TrnDirectParams {
        val isSandbox = passageMap["isSandbox"] as Boolean
        val transactionParams = passageMap["transactionParams"] as HashMap<String, Any>

        val params = TransactionParamsMapper.build(transactionParams)
        return TrnDirectParams.create(params).setSandbox(isSandbox)
    }
}