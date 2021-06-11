class SdkResult {
  final SdkStatus _status;
  final String? _payload;

  SdkResult({required SdkStatus status, String? payload})
      : this._status = status,
        this._payload = payload;

  SdkStatus get status => _status;
  String? get payload => _payload;

  factory SdkResult.fromMap(Map<dynamic, dynamic> map) {
    return SdkResult(
        status: SdkResult.getStatusFrom(map["status"]),
        payload: map["payload"]);
  }

  static SdkStatus getStatusFrom(String? result) {
    switch (result) {
      case "cancel": return SdkStatus.cancel;
      case "success": return SdkStatus.success;
      case "error": return SdkStatus.error;
      default: return SdkStatus.cancel;
    }
  }
}

enum SdkStatus { success, error, cancel }
