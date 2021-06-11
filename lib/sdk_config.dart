import 'package:flutter/services.dart';

class SdkConfig {
  static const MethodChannel _channel =
      const MethodChannel('p24_sdk/sdk_config');

  static Future setCertificatePinningEnabled(bool value) async {
    await _channel.invokeMethod("setCertificatePinningEnabled", value);
  }

  static Future setFinishOnBackButtonEnabled(bool value) async {
    await _channel.invokeMethod("setFinishOnBackButtonEnabled", value);
  }

  static Future<bool> getCertificatePinningEnabled() async {
    var isCertificatePinningEnabled = await _channel.invokeMethod<bool>("getCertificatePinningEnabled");
    return isCertificatePinningEnabled!;
  }

  static Future<bool> getFinishOnBackButtonEnabled() async {
    var isFinishOnBackButtonEnabled = await _channel.invokeMethod<bool>("getFinishOnBackButtonEnabled");
    return isFinishOnBackButtonEnabled!;
  }

}
