class ExpressParams {
  final String _url;

  ExpressParams({required String url}) : _url = url;

  String get url => _url;

  Map<String, dynamic> toMap() {
    return {
      "url": _url,
    };
  }
}
