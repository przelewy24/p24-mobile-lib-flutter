import 'package:flutter/material.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';

class GooglePayForm extends StatefulWidget {

  final String merchantId;
  final bool isSandboxEnabled;

  GooglePayForm({required this.merchantId, required this.isSandboxEnabled});

  @override
  _GooglePayFormState createState() => _GooglePayFormState();

}

class _GooglePayFormState extends State<GooglePayForm> implements GooglePayTrnRegistrar {

  SdkResult? _sdkResult;
  int _amount = 1;

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
        ElevatedButton(
          child: Text("START"),
          onPressed: () {
            _startGooglePay();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "GooglePay")
            : SizedBox.shrink(),
      ],
    );
  }

  void _startGooglePay() {
    setState(() => _sdkResult = null);

    GooglePayParams params = GooglePayParams(
        merchantId: widget.merchantId,
        amount: _amount,
        currency: "PLN",
        isSandbox: widget.isSandboxEnabled
    );

    P24SDK.googlePay(params, this).then((value) {
      setState(() {
        _sdkResult = value;
      });
    });
  }

  @override
  Future<GooglePayExchangeResult> exchange(String methodRefId) {
    //In this place your backend should register transaction in P24 and retrieve transaction token.
    var result = GooglePayTransactionRegistered(transactionToken: "CD77A8A04F-3E83BC-7C1044-0EFF8933DF");
    return Future.value(result);
  }

}