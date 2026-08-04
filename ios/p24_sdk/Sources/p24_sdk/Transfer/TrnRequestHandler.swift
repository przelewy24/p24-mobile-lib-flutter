import P24

internal struct TrnRequestHandler : TransferHandler {
    internal func start(controller: UIViewController?, dictionary: [String: Any], delegate: P24TransferDelegate) {
        let params = P24TrnRequestParams(token: (dictionary["token"] as! String))!
        params.sandbox = dictionary["isSandbox"] as! Bool
        P24.startTrnRequest(params, in: controller, delegate: delegate)
    }
}
