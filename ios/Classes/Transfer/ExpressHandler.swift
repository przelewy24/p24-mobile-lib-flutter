import P24

internal struct ExpressHandler : TransferHandler {
    func start(controller: UIViewController?, dictionary: [String: Any], delegate: P24TransferDelegate) {
        let params = P24ExpressParams(url: (dictionary["url"] as! String))!
        P24.startExpress(params, in: controller, delegate: delegate)
    }
}
