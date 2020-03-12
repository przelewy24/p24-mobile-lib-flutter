import 'package:flutter/services.dart';

class ExtraFeaturesConfig {
  static const MethodChannel _channel = const MethodChannel('p24_sdk/extra_features_config');

  static Future setRemoteConfigUrl(String remoteConfigUrl) async {
    await _channel.invokeMethod("setRemoteConfigUrl", remoteConfigUrl);
  }

  static Future enableExpressFeatures(String id) async {
    await _channel.invokeMethod("enableExpressFeatures", id);
  }

  static Future disableExpressFeatures() async {
    await _channel.invokeMethod("disableExpressFeatures");
  }

}