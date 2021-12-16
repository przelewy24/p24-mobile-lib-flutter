import 'package:p24_sdk/transfer/transaction_params.dart';

class TrnDirectParams {
  final TransactionParams _transactionParams;
  final bool _isSandbox;

  TrnDirectParams(
      {required TransactionParams transactionParams, bool isSandbox = false})
      : this._transactionParams = transactionParams,
        this._isSandbox = isSandbox;

  bool get isSandbox => _isSandbox;
  TransactionParams get transactionParams => _transactionParams;

  Map<String, dynamic> toMap() {
    return {
      "transactionParams": _transactionParams.toMap(),
      "isSandbox": _isSandbox
    };
  }
}
