class TrnRequestParams {
  final String _token;
  final bool _isSandbox;

  TrnRequestParams({required String token, bool isSandbox = false})
      : this._token = token,
        this._isSandbox = isSandbox;

  String get token => _token;

  bool get isSandbox => _isSandbox;

  Map<String, dynamic> toMap() {
    return {"token": _token, "isSandbox": _isSandbox};
  }
}
