abstract class ApplePayExchangeResult {}

class ApplePayExchangeCanceled implements ApplePayExchangeResult {}

class ApplePayTransactionRegistered implements ApplePayExchangeResult {
  final String transactionToken;
  ApplePayTransactionRegistered({this.transactionToken});
}
