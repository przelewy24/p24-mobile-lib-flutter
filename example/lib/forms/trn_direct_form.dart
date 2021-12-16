import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';
import 'package:p24_sdk_example/transaction_factory.dart';


class TrnDirectForm extends StatefulWidget {

  final bool isSandboxEnabled;
  final int merchantId;
  final String crc;

  TrnDirectForm({required this.isSandboxEnabled, required this.merchantId, required this.crc});

  @override
  _TrnDirectFormState createState() => _TrnDirectFormState();
}

class _TrnDirectFormState extends State<TrnDirectForm> {

  String _description = "Mobile Payment Test";
  String _method = "0";
  String _amount = "1";
  SdkResult? _sdkResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextFormField(
          initialValue: _amount.toString(),
          decoration: InputDecoration(labelText: "Amount (in gr)"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (currentValue){
            setState(() {
              _amount = currentValue;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Method number"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            _startTransferTrnDirect();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "TrnDirect")
            : SizedBox.shrink(),
      ],
    );
  }

  void _startTransferTrnDirect() {
    setState(() => _sdkResult = null);

    TransactionParams transactionParams = TransactionFactory.getTestTransaction(
        merchantId: widget.merchantId,
        crc: widget.crc,
        amount: int.parse(_amount),
        description: _description,
        method: int.tryParse(_method)
    );

    TrnDirectParams params = TrnDirectParams(
        transactionParams: transactionParams, isSandbox: widget.isSandboxEnabled);

    P24SDK.trnDirect(params).then((value) {
      setState(() {
        _sdkResult = value;
      });
    });
  }
}
