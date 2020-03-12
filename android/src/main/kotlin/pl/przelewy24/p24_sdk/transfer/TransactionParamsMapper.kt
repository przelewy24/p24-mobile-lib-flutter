package pl.przelewy24.p24_sdk.transfer

import pl.przelewy24.p24lib.transfer.direct.TransactionParams
import pl.przelewy24.p24lib.transfer.passage.PassageCart
import pl.przelewy24.p24lib.transfer.passage.PassageItem

object TransactionParamsMapper {
    fun build(params: HashMap<String, Any>) : TransactionParams {

        val builder = TransactionParams.Builder()

        (params["merchantId"] as Int?)?.let { builder.merchantId(it) }
        (params["crc"] as String?)?.let { builder.crc(it) }
        (params["sessionId"] as String?)?.let { builder.sessionId(it) }
        (params["amount"] as Int?)?.let { builder.amount(it) }
        (params["currency"] as String?)?.let { builder.currency(it) }
        (params["description"] as String?)?.let { builder.description(it) }
        (params["email"] as String?)?.let { builder.email(it) }
        (params["country"] as String?)?.let { builder.country(it) }
        (params["client"] as String?)?.let { builder.client(it) }
        (params["address"] as String?)?.let { builder.address(it) }
        (params["zip"] as String?)?.let { builder.zip(it) }
        (params["city"] as String?)?.let { builder.city(it) }
        (params["phone"] as String?)?.let { builder.phone(it) }
        (params["language"] as String?)?.let { builder.language(it) }
        (params["method"] as Int?)?.let { builder.method(it) }
        (params["urlStatus"] as String?)?.let { builder.urlStatus(it) }
        (params["timeLimit"] as Int?)?.let { builder.timeLimit(it) }
        (params["channel"] as Int?)?.let { builder.channel(it) }
        (params["shipping"] as Int?)?.let { builder.shipping(it) }
        (params["transferLabel"] as String?)?.let { builder.transferLabel(it) }
        (params["methodRefId"] as String?)?.let { builder.methodRefId(it) }
        (params["passageCart"] as List<Map<String, Any>>?)?.let { list ->

            val passageCart : PassageCart = PassageCart.create()

            list.map { item ->
                val passageItem: PassageItem = buildPassage(item)
                passageCart.addItem(passageItem)
            }

            builder.passageCart(passageCart)

        }

        return builder.build()

    }

    private fun buildPassage(item: Map<String, Any>): PassageItem {
        val passageItem: PassageItem.Builder = PassageItem.Builder()

        passageItem.name(item["name"] as String)
        passageItem.description(item["description"] as String)
        passageItem.quantity(item["quantity"] as Int)
        passageItem.price(item["price"] as Int)
        passageItem.number(item["number"] as Int)
        passageItem.targetAmount(item["targetAmount"] as Int)
        passageItem.targetPosId(item["targetPosId"] as Int)

        return passageItem.build()
    }

}