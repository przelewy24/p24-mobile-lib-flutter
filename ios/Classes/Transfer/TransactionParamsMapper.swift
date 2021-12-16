import P24

internal struct TransactionParamsMapper {

    internal static func buildTransaction(_ transactionParams: [String: Any]) -> P24TransactionParams {

        let p24Payment = P24TransactionParams()
        
        p24Payment.merchantId = transactionParams["merchantId"] as! Int32
        p24Payment.crc = transactionParams["crc"] as? String
        p24Payment.sessionId = transactionParams["sessionId"] as? String
        p24Payment.amount = transactionParams["amount"] as! Int32
        p24Payment.currency = transactionParams["currency"] as? String
        p24Payment.desc = transactionParams["description"] as? String
        p24Payment.email = transactionParams["email"] as? String
        
        p24Payment.country = transactionParams["country"] as? String
        p24Payment.client = transactionParams["client"] as? String
        p24Payment.address = transactionParams["address"] as? String
        p24Payment.zip = transactionParams["zip"] as? String
        p24Payment.city = transactionParams["city"] as? String
        p24Payment.phone = transactionParams["phone"] as? String
        p24Payment.language = transactionParams["language"] as? String
        p24Payment.method = transactionParams["method"] as! Int32
        p24Payment.language = transactionParams["language"] as? String
        p24Payment.urlStatus = transactionParams["urlStatus"] as? String
        p24Payment.transferLabel = transactionParams["transferLabel"] as? String

        if let timeLimit = transactionParams["timeLimit"] as? Int32 { p24Payment.timeLimit = timeLimit }
        if let channel = transactionParams["channel"] as? Int32 { p24Payment.channel = channel }
        if let shipping = transactionParams["shipping"] as? Int32 { p24Payment.shipping = shipping}
        
        if let itemsList = transactionParams["passageCart"] as? NSArray, itemsList.count > 0 {
            let cart = buildPassageCart(itemsList)
            p24Payment.passageCart = cart
            p24Payment.amount = cart.getSummaryPrice()
        }

        return p24Payment
    }

    private static func buildPassageCart(_ itemsList: NSArray) -> P24PassageCart {
        let passageCart = P24PassageCart()
        itemsList.forEach { item in
            let passageItem = buildPassageItem(item as! NSDictionary)
            passageCart.addItem(passageItem)
        }
        return passageCart
    }

    private static func buildPassageItem(_ dictionary: NSDictionary) -> P24PassageItem {
        let passageItem = P24PassageItem()
        passageItem.name = dictionary["name"] as? String
        passageItem.desc = dictionary["description"] as? String
        passageItem.quantity = dictionary["quantity"] as! Int32
        passageItem.price = dictionary["price"] as! Int32
        passageItem.number = dictionary["number"] as! Int32
        passageItem.targetAmount = dictionary["targetAmount"] as! Int32
        passageItem.targetPosId = dictionary["targetPosId"] as! Int32
        return passageItem
    }
}

