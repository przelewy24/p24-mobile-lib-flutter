import P24

internal struct TrnDirectHandler : TransferHandler {
    internal func start(controller: UIViewController?, dictionary: [String: Any], delegate: P24TransferDelegate) {
        let transactionParams = TransactionParamsMapper.buildTransaction(dictionary["transactionParams"] as! [String: Any])
        let params = P24TrnDirectParams(transactionParams: transactionParams)!
        params.sandbox =  dictionary["isSandbox"] as! Bool
        P24.startTrnDirect(params, in: controller, delegate: delegate)
    }
}

