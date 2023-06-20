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
            break
        case "getCertificatePinningEnabled":
            result(P24SdkConfig.isCertificatePinningEnabled())
            break
        case "setFinishOnBackButtonEnabled":
            let isFinishOnBackButtonEnabled = call.arguments as! Bool
            P24SdkConfig.setExitOnBackButtonEnabled(isFinishOnBackButtonEnabled)
            result("")
            break
        case "getFinishOnBackButtonEnabled":
            result(P24SdkConfig.isExitOnBackButtonEnabled())
            break
        case "setSplitPaymentEnabled":
            let isSplitPaymentEnabled = call.arguments as! Bool
            P24SdkConfig.setSplitPaymentEnabled(isSplitPaymentEnabled)
            result("")
            break
        case "getSplitPaymentEnabled":
            result(P24SdkConfig.isSplitPaymentEnabled())
            break
        case "overrideCancelButtonText":
            let text = call.arguments as! String
            P24SdkConfig.overrideCancelButtonText(text)
            result("")
            break
        case "getOverridedCancelButtonText":
            result(P24SdkConfig.getOverridedCancelButtonText() ?? "")
            break
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
