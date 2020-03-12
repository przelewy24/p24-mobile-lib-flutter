import 'dart:async';

import 'package:flutter/services.dart';
import 'package:p24_sdk/apple_pay/apple_pay_params.dart';
import 'package:p24_sdk/apple_pay/apple_pay_registrar_channel.dart';
import 'package:p24_sdk/apple_pay/apple_pay_trn_registrar.dart';
import 'package:p24_sdk/google_pay/google_pay_params.dart';
import 'package:p24_sdk/google_pay/google_pay_registrar_channel.dart';
import 'package:p24_sdk/google_pay/google_pay_trn_registrar.dart';
import 'package:p24_sdk/card/register_card_params.dart';
import 'package:p24_sdk/sdk_result.dart';
import 'package:p24_sdk/transfer/trn_direct_params.dart';
import 'package:p24_sdk/transfer/trn_request_params.dart';
import 'package:p24_sdk/transfer/express_params.dart';

class P24SDK {

  static const MethodChannel _channel = const MethodChannel('p24_sdk');

  static Future<String> getSdkVersion() async {
    return await _channel.invokeMethod('getSdkVersion');
  }

  static Future<SdkResult> trnRequest(TrnRequestParams params) async {
    var result = await _channel.invokeMethod('trnRequest', params.toMap());
    return SdkResult.fromMap(result);
  }

  static Future<SdkResult> trnDirect(TrnDirectParams params) async {
    var result = await _channel.invokeMethod('trnDirect', params.toMap());
    return SdkResult.fromMap(result);
  }

  static Future<SdkResult> transferExpress(ExpressParams params) async {
    var result = await _channel.invokeMethod("transferExpress", params.toMap());
    return SdkResult.fromMap(result);
  }

  static Future<SdkResult> transferPassage(TrnDirectParams params) async {
    var result = await _channel.invokeMethod("transferPassage", params.toMap());
    return SdkResult.fromMap(result);
  }

  static Future<SdkResult> googlePay(GooglePayParams params, GooglePayTrnRegistrar registrar) async {
    GooglePayRegistrarChannel.bind(registrar);
    var result = await _channel.invokeMethod("googlePay", params.toMap());
    return SdkResult.fromMap(result);
  }

  static Future<SdkResult> applePay(ApplePayParams params, ApplePayTrnRegistrar registrar) async {
    ApplePayRegistrarChannel.bind(registrar);
    var result = await _channel.invokeMethod("applePay", params.toMap());
    return SdkResult.fromMap(result);
  }

  static Future<SdkResult> registerCard(RegisterCardParams params) async {
    var result = await _channel.invokeMethod("registerCard", params.toMap());
    return SdkResult.fromMap(result);
  }

}
