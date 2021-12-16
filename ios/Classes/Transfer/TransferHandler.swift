import P24

internal protocol TransferHandler {
    func start(controller: UIViewController?, dictionary: [String: Any], delegate: P24TransferDelegate)
}
