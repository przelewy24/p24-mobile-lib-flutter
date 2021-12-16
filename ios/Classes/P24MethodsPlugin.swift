import P24

public class P24MethodsPlugin: NSObject, FlutterPlugin {
    
    private var executor: TransferExecutor?
    private var cardHandler: CardHandler?
    private var applePayHandler: ApplePayHandler?
    
    private let binaryMessenger: FlutterBinaryMessenger
    
    internal init(binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let binaryMessenger = registrar.messenger()
        registrar.addMethodCallDelegate(P24MethodsPlugin(binaryMessenger: binaryMessenger), channel: FlutterMethodChannel(name: "p24_sdk", binaryMessenger: binaryMessenger))
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        executor = TransferExecutor(flutterResult: result)
        cardHandler = CardHandler(flutterResult: result)
        applePayHandler = ApplePayHandler(flutterResult: result, registar: ApplePayRegistrarChannel(with: binaryMessenger))
        
        let arguments = call.arguments as! [String: Any]
        
        switch(call.method) {
            case "trnRequest":      executor?.execute(dictionary: arguments, handler: TrnRequestHandler())
            case "trnDirect":       executor?.execute(dictionary: arguments, handler: TrnDirectHandler())
            case "transferPassage": executor?.execute(dictionary: arguments, handler: TrnDirectHandler())
            case "transferExpress": executor?.execute(dictionary: arguments, handler: ExpressHandler())
            case "registerCard":    cardHandler?.start(dictionary: arguments)
            case "applePay":        applePayHandler?.start(dictionary: arguments)
            default:                result(FlutterMethodNotImplemented)
        }
        
    }
    
}
