import 'package:flutter/foundation.dart';

class ExpressParams {
  final String _url;

  ExpressParams({@required String url}) : this._url = url;

  String get url => _url;

  Map<String, dynamic> toMap() {
    return {
      "url": _url,
    };
  }
}
