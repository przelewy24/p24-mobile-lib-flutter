import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';

class TrnRequestForm extends StatefulWidget {

  final bool isSandboxEnabled;

  TrnRequestForm({this.isSandboxEnabled});

  @override
  _TrnRequestFormState createState() => _TrnRequestFormState();

}

class _TrnRequestFormState extends State<TrnRequestForm> {

  String _token = "";
  SdkResult _sdkResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: "Token"),
          onChanged: (currentValue) {
            setState(() => _token = currentValue);
          },
        ),
        Container(
          height: 16,
        ),
        RaisedButton(
          child: Text("START"),
          onPressed: () {
            _startTransferTrnRequest();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "TrnRequest",)
            : Container(),
      ],
    );
  }

  void _startTransferTrnRequest() {
    setState(() => _sdkResult = null);

    TrnRequestParams params = TrnRequestParams(token: _token, isSandbox: widget.isSandboxEnabled);
    P24SDK.trnRequest(params).then((value) {
      setState(() => _sdkResult = value);
    });
  }
}
