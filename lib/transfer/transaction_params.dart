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

  final String? _client;
  final String? _address;
  final String? _zip;
  final String? _city;
  final String? _phone;
  final String? _language;
  final int? _method;
  final String? _urlStatus;
  final int? _timeLimit;
  final int? _channel;
  final int? _shipping;
  final String? _transferLabel;
  final String? _methodRefId;

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
      : _merchantId = merchantId,
        _crc = crc,
        _sessionId = sessionId,
        _amount = amount,
        _currency = currency,
        _description = description,
        _email = email,
        _country = country,
        _client = client,
        _address = address,
        _zip = zip,
        _city = city,
        _phone = phone,
        _language = language,
        _method = method,
        _urlStatus = urlStatus,
        _timeLimit = timeLimit,
        _channel = channel,
        _shipping = shipping,
        _transferLabel = transferLabel,
        _methodRefId = methodRefId;

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
