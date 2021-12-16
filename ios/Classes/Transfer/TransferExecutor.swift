import P24

internal class TransferExecutor : NSObject, P24TransferDelegate {
    
    private let flutterResult: FlutterResult
    
    internal init(flutterResult: @escaping FlutterResult) {
        self.flutterResult = flutterResult
    }
    
    internal func execute(dictionary: [String: Any], handler: TransferHandler) {
        handler.start(controller:  RootViewControllerProvider.shared, dictionary: dictionary, delegate: self)
    }
    
    internal func p24TransferOnSuccess() {
        flutterResult(["status" : "success"])
    }
    
    internal func p24Transfer(onError errorCode: String!) {
        flutterResult(["status" : "error", "payload" : errorCode])
    }
    
    internal func p24TransferOnCanceled() {
        flutterResult(["status" : "cancel"])
    }
    
}


