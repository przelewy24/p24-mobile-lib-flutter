import P24

internal class ApplePayHandler: NSObject {
    
    private let flutterResult: FlutterResult
    private let registar: ApplePayRegistrarChannel
    
    internal init(flutterResult: @escaping FlutterResult, registar: ApplePayRegistrarChannel) {
        self.flutterResult = flutterResult
        self.registar = registar
    }
    
    internal func start(dictionary: [String: Any]) {
        let params = parseApplePayParams(dictionary)
        params.sandbox = dictionary["isSandbox"] as! Bool
        P24.startApplePay(params, in: RootViewControllerProvider.shared, delegate: self)
    }
    
    private func parseApplePayParams(_ dict: [String: Any]) -> P24ApplePayParams {
        let appleMerchantId = dict["appleMerchantId"] as! String
        let currency = dict["currency"] as! String
        let items = getItemsList(dict["items"] as! [[String: Any]])
        return P24ApplePayParams(items: items, currency: currency, appleMerchantId: appleMerchantId, registrar: registar)
    }
    
    private func getItemsList(_ itemsList: [[String: Any]]) -> [PaymentItem] {
        return itemsList.map {
            let item = PaymentItem()
            item.amount = $0["amount"] as! Int32
            item.itemDescription = ($0["description"] as! String)
            return item
        }
    }
}

extension ApplePayHandler: P24ApplePayDelegate {
    func p24ApplePayOnSuccess() {
        flutterResult(["status" : "success"])
    }
    
    func p24ApplePay(onError errorCode: String!) {
        flutterResult(["status" : "error", "payload" : errorCode])
    }
    
    func p24ApplePayOnCanceled() {
        flutterResult(["status" : "cancel"])
    }
    
}
