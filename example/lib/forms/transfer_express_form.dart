import 'package:flutter/material.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';


class TransferExpressForm extends StatefulWidget {

  final int merchantId;

  const TransferExpressForm({super.key, required this.merchantId});

  @override
  State<TransferExpressForm> createState() => _TransferExpressFormState();
}

class _TransferExpressFormState extends State<TransferExpressForm> {

  SdkResult? _sdkResult;
  String _expressUrl = "https://e.przelewy24.pl/ESGByXP2S1SMxDm";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextFormField(
          initialValue: _expressUrl,
          decoration: const InputDecoration(labelText: "Express URL"),
          onChanged: (currentValue) {
            setState(() {
              _expressUrl = currentValue;
            });
          },
        ),
        ElevatedButton(
          child: const Text("START"),
          onPressed: () {
            _startTransferExpress();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "Express")
            : const SizedBox.shrink(),
      ],
    );
  }

  void _startTransferExpress() async {
    setState(() => _sdkResult = null);
    ExpressParams params = ExpressParams(url: _expressUrl);

    P24SDK.transferExpress(params).then((value) {
      setState(() => _sdkResult = value);
    });

  }
}
