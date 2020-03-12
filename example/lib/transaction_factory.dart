import 'package:flutter/cupertino.dart';
import 'package:p24_sdk/p24_sdk.dart';

class TransactionFactory {

  static const FIRST_BILLING_PASSAGE_ACCOUNT = 51986;
  static const SECOND_BILLING_PASSAGE_ACCOUNT = 51987;

  static TransactionParams getTestTransaction({@required merchantId, @required String crc, @required int amount, @required String description, int method}){
    return TransactionParams(
      merchantId: merchantId,
      crc: crc,
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      currency: "PLN",
      description: description,
      email: "test@test.pl",
      country: "PL",
      method: method,
    );
  }

  static PassageCart getPassageCart() {
    List<PassageItem> _items = List<PassageItem>();

    for (int i = 0; i<10; i++) {
      int price = 2 * (100 + i);

      PassageItem item = PassageItem(
          name: "Product name $i",
          description: "Product description $i",
          number: i,
          price: (price ~/ 2).toInt(),
          quantity: 2,
          targetAmount: price,
          targetPosId: (i / 2 == 1)
              ? FIRST_BILLING_PASSAGE_ACCOUNT
              : SECOND_BILLING_PASSAGE_ACCOUNT
      );
      _items.add(item);
    }

    return PassageCart(_items);
  }
}