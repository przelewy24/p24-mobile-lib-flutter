import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';
import 'package:p24_sdk_example/transaction_factory.dart';

class TransferPassageForm extends StatefulWidget {

  final bool isSandboxEnabled;
  final int merchantId;
  final String crc;

  TransferPassageForm({required this.isSandboxEnabled, required this.merchantId, required this.crc});

  @override
  _TransferPassageFormState createState() => _TransferPassageFormState();
}

class _TransferPassageFormState extends State<TransferPassageForm> {

  String _description = "Mobile Payment Test";
  String _method = "0";
  SdkResult? _sdkResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: "Method number"),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          onChanged: (currentValue) {
            setState(() {
              _method = currentValue;
            });
          },
        ),
        TextFormField(
          initialValue: _description,
          decoration: InputDecoration(labelText: "Description"),
          onChanged: (currentValue) {
            setState(() {
              _description = currentValue;
            });
          },
        ),
        ElevatedButton(
          child: Text("START"),
          onPressed: () {
            _startTransferPassage();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "Passage")
            : SizedBox.shrink(),
      ],
    );
  }


  void _startTransferPassage() {
    setState(() => _sdkResult = null);

    TrnDirectParams params = TrnDirectParams(
        transactionParams: _getTestPaymentForPassage(),
        isSandbox: widget.isSandboxEnabled
    );

    P24SDK.transferPassage(params).then((value) {
      setState(() => _sdkResult = value);
    });
  }

  TransactionParams _getTestPaymentForPassage() {
    TransactionParams transactionParams = TransactionFactory.getTestTransaction(
        merchantId: widget.merchantId,
        crc: widget.crc,
        amount: 1,
        description: _description,
        method: int.tryParse(_method)
    );
    PassageCart cart = TransactionFactory.getPassageCart();
    transactionParams.passageCart = cart;

    return transactionParams;
  }
}

