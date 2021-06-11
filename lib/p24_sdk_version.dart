import 'package:flutter/services.dart';

class P24SdkVersion {

	static const MethodChannel _channel = const MethodChannel('p24_sdk/p24_sdk_version');

	static Future<String> value() async {
		var sdkVersion = await _channel.invokeMethod("getP24SdkVersion");
		return sdkVersion!;
	}

}
