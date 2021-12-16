import P24

public class P24SdkConfigPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.addMethodCallDelegate(P24SdkConfigPlugin(), channel: FlutterMethodChannel(name: "p24_sdk/sdk_config", binaryMessenger: registrar.messenger()))
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
        case "setCertificatePinningEnabled":
            let isPinningEnabled = call.arguments as! Bool
            P24SdkConfig.setCertificatePinningEnabled(isPinningEnabled)
            result("")
        case "setFinishOnBackButtonEnabled":
            let isFinishOnBackButtonEnabled = call.arguments as! Bool
            P24SdkConfig.setExitOnBackButtonEnabled(isFinishOnBackButtonEnabled)
            result("")
        case "getCertificatePinningEnabled":
            result(P24SdkConfig.isCertificatePinningEnabled())
        case "getFinishOnBackButtonEnabled":
            result(P24SdkConfig.isExitOnBackButtonEnabled())
        default:
            result(FlutterMethodNotImplemented)
    }
  }
    
}
