import P24

internal class CardHandler : NSObject {
    
    private let flutterResult: FlutterResult
    
    internal init(flutterResult: @escaping FlutterResult) {
        self.flutterResult = flutterResult
    }
    
    internal func start(dictionary: [String: Any]) {
        let vc = RootViewControllerProvider.shared
        let url = (dictionary["url"] as! String)
        if let cardData = dictionary["cardData"] as? [String: Any] {
            P24.startRegisterCard(P24RegisterCardParams(url: url, data: parse(cardData)), in: vc, delegate: self)
        } else {
            P24.startRegisterCard(P24RegisterCardParams(url: url), in: vc, delegate: self)
        }
    }
    
    private func parse(_ cardData: [String: Any]) -> P24CardData {
        let number = cardData["number"] as? String
        let expiryMonth = cardData["expiryMonth"] as? Int32
        let expiryYear = cardData["expiryYear"] as? Int32
        let cvv = cardData["cvv"] as? String
        return P24CardData(cardNumber: number, month: expiryMonth ?? 0, year: expiryYear ?? 0, cvv: cvv)
    }
}

extension CardHandler : P24RegisterCardDelegate {
    func p24RegisterCardSuccess(_ registerCardResult: P24RegisterCardResult!) {
        flutterResult(["status" : "success", "payload" : registerCardResult.cardToken])
    }
    
    func p24RegisterCardError(_ errorCode: String!) {
        flutterResult(["status" : "error", "payload" : errorCode])
    }
    
    func p24RegisterCardCancel() {
        flutterResult(["status" : "cancel"])
    }
}
