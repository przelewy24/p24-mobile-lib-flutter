class GooglePayParams {
  final String _merchantId;
  final int _amount;
  final String _currency;
  final bool _isSandbox;

  GooglePayParams(
      {required int merchantId,
        required int amount,
        required String currency,
        bool isSandbox = false})
      : _merchantId = merchantId.toString(),
        _amount = amount,
        _currency = currency,
        _isSandbox = isSandbox;

  GooglePayParams.of(
      {required String merchantId,
      required int amount,
      required String currency,
      bool isSandbox = false})
      : _merchantId = merchantId,
        _amount = amount,
        _currency = currency,
        _isSandbox = isSandbox;

  String get merchantId => _merchantId;
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
