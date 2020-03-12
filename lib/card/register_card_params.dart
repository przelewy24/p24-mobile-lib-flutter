import 'package:p24_sdk/card/card_data.dart';

class RegisterCardParams {
  final String _url;
  final CardData _cardData;

  RegisterCardParams({String url, CardData cardData})
      : this._url = url,
        this._cardData = null;

  RegisterCardParams.prefilled({String url, CardData cardData})
      : this._url = url,
        this._cardData = cardData;

  CardData get cardData => _cardData;
  String get url => _url;

  Map<String, dynamic> toMap() {
    return {
      "url": _url,
      "cardData": _cardData.toMap(),
    };
  }
}
