import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:p24_sdk/apple_pay/apple_pay_trn_registrar.dart';

import 'apple_pay_exchange_result.dart';

class ApplePayRegistrarChannel {
  static const BasicMessageChannel<String?> _channel =
      BasicMessageChannel("apple_pay_exchange", StringCodec());

  static void bind(ApplePayTrnRegistrar registrar) {
    _channel.setMessageHandler(
        (message) => registrar.exchange(message!).then(_mapExchangeResult));
  }

  static Future<String> _mapExchangeResult(
      ApplePayExchangeResult result) async {
    if (result is ApplePayTransactionRegistered) {
      return _mapToJson({
        "status": "transaction_registered",
        "transactionToken": result.transactionToken
      });
    } else if (result is ApplePayExchangeCanceled) {
      return _mapToJson({"status": "exchange_canceled"});
    }

    throw Error();
  }

  static String _mapToJson(Map<String, dynamic> data) {
    return jsonEncode(data);
  }
}
