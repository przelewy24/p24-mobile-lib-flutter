import 'package:p24_sdk/apple_pay/apple_pay_exchange_result.dart';

abstract class ApplePayTrnRegistrar {

  Future<ApplePayExchangeResult> exchange(String methodRefId);

}

