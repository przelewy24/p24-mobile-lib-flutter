import 'package:flutter/foundation.dart';

class ApplePayParams {
  String _appleMerchantId;
  int _amount;
  String _currency;
  bool _isSandbox;

  ApplePayParams(
      {@required String appleMerchantId,
      @required int amount,
      @required String currency,
      bool isSandbox = true})
      : this._appleMerchantId = appleMerchantId,
        this._amount = amount,
        this._currency = currency,
        this._isSandbox = isSandbox;

  String get appleMerchantId => _appleMerchantId;
  int get amount => _amount;
  bool get isSandbox => _isSandbox;
  String get currency => _currency;

  Map<String, dynamic> toMap() {
    return {
      "appleMerchantId": _appleMerchantId,
      "amount": _amount,
      "currency": _currency,
      "isSandbox": _isSandbox
    };
  }
}
