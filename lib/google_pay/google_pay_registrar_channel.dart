import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:p24_sdk/google_pay/google_pay_exchange_result.dart';
import 'package:p24_sdk/google_pay/google_pay_trn_registrar.dart';

class GooglePayRegistrarChannel {
  static const BasicMessageChannel<String> _channel =
      BasicMessageChannel("google_pay_exchange", StringCodec());

  static void bind(GooglePayTrnRegistrar registrar) {
    _channel.setMessageHandler((message) => registrar
        .exchange(message)
        .then((result) => _mapExchangeResult(result)));
  }

  static Future<String> _mapExchangeResult(
      GooglePayExchangeResult result) async {
    if (result is GooglePayTransactionRegistered) {
      return _mapToJson({
        "status": "transaction_registered",
        "transactionToken": result.transactionToken
      });
    } else if (result is GooglePayExchangeCanceled) {
      return _mapToJson({"status": "exchange_canceled"});
    }

    throw Error();
  }

  static String _mapToJson(Map<String, dynamic> data) {
    return jsonEncode(data);
  }
}
