import 'package:flutter/material.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';

class ApplePayForm extends StatefulWidget {

  final bool isSandboxEnabled;

  ApplePayForm({required this.isSandboxEnabled});

  @override
  _ApplePayFormState createState() => _ApplePayFormState();

}

class _ApplePayFormState extends State<ApplePayForm> implements ApplePayTrnRegistrar {

  SdkResult? _sdkResult;
  int _amount = 1;
  String _appleMerchantId = "merchant.Przelewy24.sandbox";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextFormField(
          initialValue: _amount.toString(),
          decoration: InputDecoration(labelText: "Amount"),
          onChanged: (currentValue) {
            setState(() {
              _amount = int.parse(currentValue);
            });
          },
        ),
        TextFormField(
          initialValue: _appleMerchantId,
          decoration: InputDecoration(labelText: "Apple Merchant Id"),
          onChanged: (currentValue) {
            setState(() {
              _appleMerchantId = currentValue;
            });
          },
        ),
        ElevatedButton(
          child: Text("START"),
          onPressed: () {
            _startApplePay();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "ApplePay")
            : Container(),
      ],
    );
  }

  void _startApplePay() {
    setState(() => _sdkResult = null);

    ApplePayParams params = ApplePayParams.withSingleItem(
        appleMerchantId: _appleMerchantId,
        amount: _amount,
        currency: "PLN",
        description: "Test payment",
        isSandbox: widget.isSandboxEnabled
    );

    P24SDK.applePay(params, this).then((value) {
      setState(() {
        _sdkResult = value;
      });
    });

//		ApplePayParams params = ApplePayParams.withMultipleItems(
//			appleMerchantId: _appleMerchantId,
//			items: _buildApplePayItems(),
//			currency: "PLN",
//			isSandbox: widget.isSandboxEnabled
//		);

  }

  // List<PaymentItem> _buildApplePayItems() {
  // 	PaymentItem firstItem = PaymentItem(description: "first item", amount: 12);
	// 	PaymentItem secondItem = PaymentItem(description: "second item", amount: 18);
	// 	return [firstItem, secondItem];
	// }

  @override
  Future<ApplePayExchangeResult> exchange(String methodRefId) {
    //In this place your backend should register transaction in P24 and retrieve transaction token.
    var result = ApplePayTransactionRegistered(transactionToken: "D485AEB65C-C0F20B-9BC29D-BA835F21C4");
    return Future.value(result);
  }
}
