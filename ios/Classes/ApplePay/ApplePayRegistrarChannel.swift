import P24

internal class ApplePayRegistrarChannel: NSObject, P24ApplePayTransactionRegistrar {
    
    internal let binaryMessenger: FlutterBinaryMessenger
    
    internal init(with binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
    }
    
    internal func exchange(_ applePayToken: String!, delegate: P24ApplePayTransactionRegistrarDelegate!) {
        FlutterBasicMessageChannel(name: "apple_pay_exchange", binaryMessenger: binaryMessenger, codec: FlutterStringCodec.sharedInstance()).sendMessage(applePayToken) { response in
            if let responseData = (response as! String).data(using: .utf8),
               let responseDictionary = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] {
                let status = responseDictionary["status"] as! String
                if(status == "transaction_registered") {
                    delegate.onRegisterSuccess((responseDictionary["transactionToken"] as! String))
                } else if(status == "exchange_canceled") {
                    delegate.onRegisterCanceled()
                }
            }
        }
    }
}


