import Flutter
import UIKit
import P24

public class P24SdkVersionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.addMethodCallDelegate(P24SdkVersionPlugin(), channel: FlutterMethodChannel(name: "p24_sdk/p24_sdk_version", binaryMessenger: registrar.messenger()))
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
        case "getP24SdkVersion":
            result(P24.sdkVersion())
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
