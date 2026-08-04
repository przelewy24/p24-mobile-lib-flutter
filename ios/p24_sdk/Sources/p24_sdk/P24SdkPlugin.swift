import Flutter
import UIKit

public class P24SdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    P24SdkVersionPlugin.register(with: registrar)
    P24SdkConfigPlugin.register(with: registrar)
    P24MethodsPlugin.register(with: registrar)
  }
}
