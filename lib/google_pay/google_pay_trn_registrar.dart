import 'package:p24_sdk/google_pay/google_pay_exchange_result.dart';

abstract class GooglePayTrnRegistrar {
  Future<GooglePayExchangeResult> exchange(String methodRefId);
}
