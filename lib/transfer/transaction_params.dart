import 'package:p24_sdk/transfer/passage_cart.dart';

class TransactionParams {
  final int _merchantId;
  final String _crc;
  final String _sessionId;
  final int _amount;
  final String _currency;
  final String _description;
  final String _email;
  final String _country;

  String? _client;
  String? _address;
  String? _zip;
  String? _city;
  String? _phone;
  String? _language;
  int? _method;
  String? _urlStatus;
  int? _timeLimit;
  int? _channel;
  int? _shipping;
  String? _transferLabel;
  String? _methodRefId;

  PassageCart? passageCart;

  TransactionParams(
      {required int merchantId,
      required String crc,
      required String sessionId,
      required int amount,
      required String currency,
      required String description,
      required String email,
      required String country,
      String? client,
      String? address,
      String? zip,
      String? city,
      String? phone,
      String? language,
      int? method,
      String? urlStatus,
      int? timeLimit,
      int? channel,
      int? shipping,
      String? transferLabel,
      String? methodRefId,
      PassageCart? passageCart})
      : this._merchantId = merchantId,
        this._crc = crc,
        this._sessionId = sessionId,
        this._amount = amount,
        this._currency = currency,
        this._description = description,
        this._email = email,
        this._country = country,
        this._client = client,
        this._address = address,
        this._zip = zip,
        this._city = city,
        this._phone = phone,
        this._language = language,
        this._method = method,
        this._urlStatus = urlStatus,
        this._timeLimit = timeLimit,
        this._channel = channel,
        this._shipping = shipping,
        this._transferLabel = transferLabel,
        this._methodRefId = methodRefId;

  int get merchantId => _merchantId;
  String get crc => _crc;
  String get sessionId => _sessionId;
  int get amount => _amount;
  String get currency => _currency;
  String get description => _description;
  String get email => _email;
  String get country => _country;
  String? get client => _client;
  String? get address => _address;
  String? get zip => _zip;
  String? get city => _city;
  String? get phone => _phone;
  String? get language => _language;
  int? get method => _method;
  String? get urlStatus => _urlStatus;
  int? get timeLimit => _timeLimit;
  int? get channel => _channel;
  int? get shipping => _shipping;
  String? get transferLabel => _transferLabel;
  String? get methodRefId => _methodRefId;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> transactionParams = {};

    putIfValueNotNull("merchantId", _merchantId, transactionParams);
    putIfValueNotNull("crc", _crc, transactionParams);
    putIfValueNotNull("sessionId", _sessionId, transactionParams);
    putIfValueNotNull("amount", _amount, transactionParams);
    putIfValueNotNull("currency", _currency, transactionParams);
    putIfValueNotNull("description", _description, transactionParams);
    putIfValueNotNull("email", _email, transactionParams);
    putIfValueNotNull("country", _country, transactionParams);
    putIfValueNotNull("client", _client, transactionParams);
    putIfValueNotNull("address", _address, transactionParams);
    putIfValueNotNull("zip", _zip, transactionParams);
    putIfValueNotNull("city", _city, transactionParams);
    putIfValueNotNull("phone", _phone, transactionParams);
    putIfValueNotNull("language", _language, transactionParams);
    putIfValueNotNull("method", _method, transactionParams);
    putIfValueNotNull("urlStatus", _urlStatus, transactionParams);
    putIfValueNotNull("timeLimit", _timeLimit, transactionParams);
    putIfValueNotNull("channel", _channel, transactionParams);
    putIfValueNotNull("shipping", _shipping, transactionParams);
    putIfValueNotNull("transferLabel", _transferLabel, transactionParams);
    putIfValueNotNull("methodRefId", _methodRefId, transactionParams);
    putIfValueNotNull("passageCart",
        (passageCart != null) ? passageCart!.toMap() : null, transactionParams);

    return transactionParams;
  }

  void putIfValueNotNull(String key, dynamic value, Map<String, dynamic> map) {
    if (value != null) {
      map[key] = value;
    }
  }
}
