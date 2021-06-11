import 'package:p24_sdk/card/card_data.dart';

class RegisterCardParams {
  final String _url;
  final CardData? _cardData;

  RegisterCardParams({required String url, required CardData cardData})
      : this._url = url,
        this._cardData = null;

  RegisterCardParams.prefilled({required String url, required CardData cardData})
      : this._url = url,
        this._cardData = cardData;

  String get url => _url;
  CardData? get cardData => _cardData;

  Map<String, dynamic> toMap() {
    return {
      "url": _url,
      "cardData": _cardData?.toMap(),
    };
  }
}
