class CardData {
  final String _number;
  final int _expiryMonth;
  final int _expiryYear;
  final String _cvv;

  CardData({required String number, required int expiryMonth, required int expiryYear, required String cvv})
      : this._number = number,
        this._expiryMonth = expiryMonth,
        this._expiryYear = expiryYear,
        this._cvv = cvv;

  String get cvv => _cvv;
  int get expiryYear => _expiryYear;
  int get expiryMonth => _expiryMonth;
  String get number => _number;

  Map<String, dynamic> toMap() {
  Map<String, dynamic> cardData = {};

    putIfValueNotNull("cvv", _cvv, cardData);
    putIfValueNotNull("expiryYear", _expiryYear, cardData);
    putIfValueNotNull("expiryMonth", _expiryMonth, cardData);
    putIfValueNotNull("number", _number, cardData);

    return cardData;
  }

  void putIfValueNotNull(String key, dynamic value, Map<String, dynamic> map) {
    if (value != null) {
      map[key] = value;
    }
  }
}
