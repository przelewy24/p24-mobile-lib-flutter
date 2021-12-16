class GooglePayParams {
  int _merchantId;
  int _amount;
  String _currency;
  bool _isSandbox;

  GooglePayParams(
      {required int merchantId,
      required int amount,
      required String currency,
      bool isSandbox = false})
      : this._merchantId = merchantId,
        this._amount = amount,
        this._currency = currency,
        this._isSandbox = isSandbox;

  int get merchantId => _merchantId;
  int get amount => _amount;
  bool get isSandbox => _isSandbox;
  String get currency => _currency;

  Map<String, dynamic> toMap() {
    return {
      "merchantId": _merchantId,
      "amount": _amount,
      "currency": _currency,
      "isSandbox": _isSandbox
    };
  }
}
