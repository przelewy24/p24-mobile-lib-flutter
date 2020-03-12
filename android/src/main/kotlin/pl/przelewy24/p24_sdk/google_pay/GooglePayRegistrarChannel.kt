package pl.przelewy24.p24_sdk.google_pay

import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StringCodec
import org.json.JSONObject
import pl.przelewy24.p24lib.google_pay.GooglePayTransactionRegistrar

class GooglePayRegistrarChannel(messenger: BinaryMessenger) : GooglePayTransactionRegistrar {

    private var channel = BasicMessageChannel(messenger, "google_pay_exchange", StringCodec.INSTANCE)

    override fun register(methodRefId: String, callback: GooglePayTransactionRegistrar.GooglePayTransactionRegistrarCallback) {
        channel.send(methodRefId) { reply ->
            val json = JSONObject(reply)
            when(json.getString("status")) {
                "transaction_registered" -> callback.onTransactionRegistered(json.getString("transactionToken"))
                "exchange_canceled" -> callback.onTransactionRegisterCanceled()
            }

        }
    }

}