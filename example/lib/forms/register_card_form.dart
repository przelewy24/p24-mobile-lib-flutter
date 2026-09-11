import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/sdk_status_widget.dart';


class RegisterCardForm extends StatefulWidget {
  const RegisterCardForm({super.key});


  @override
  State<RegisterCardForm> createState() => _RegisterCardFormState();
}

class _RegisterCardFormState extends State<RegisterCardForm> {

  static const registerCardUrl = "https://sandbox.przelewy24.pl/bundle/card?lang=PL&merchantId=46862&userId=y8vp5sf5wf&sessionId=1&sign=ce91e29bfdf708c2989f610cc955b5dc4b3fdb5619762d4332550c37d6e6a7b5f049ca3c9ad1e89977a7e82287bacdef";

  SdkResult? _sdkResult;

  String _number = "1111111111111111";
  int _expiryMonth = 4;
  int _expiryYear = 2021;
  String _cvv = "312";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextFormField(
          initialValue: _number,
          decoration: const InputDecoration(labelText: "Card Number"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (currentValue){
            setState(() {
              _number = currentValue;
            });
          },
        ),
        TextFormField(
          initialValue: _expiryYear.toString(),
          decoration: const InputDecoration(labelText: "Expiry year"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (currentValue){
            setState(() {
              _expiryYear = int.parse(currentValue);
            });
          },
        ),
        TextFormField(
          initialValue: _expiryMonth.toString(),
          decoration: const InputDecoration(labelText: "Expiry month"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (currentValue){
            setState(() {
              _expiryMonth = int.parse(currentValue);
            });
          },
        ),
        TextFormField(
          initialValue: _cvv,
          decoration: const InputDecoration(labelText: "CVV"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (currentValue){
            setState(() {
              _cvv = currentValue;
            });
          },
        ),
        ElevatedButton(
          child: const Text("START"),
          onPressed: () {
            _startRegisterCard();
          },
        ),
        (_sdkResult != null)
            ? SdkStatusWidget(sdkResult: _sdkResult, prefix: "Register Card",)
            : const SizedBox.shrink()
      ],
    );
  }

  void _startRegisterCard() {
    setState(() => _sdkResult = null);

    CardData cardData = CardData(
        number: _number,
        cvv: _cvv,
        expiryMonth: _expiryMonth,
        expiryYear: _expiryYear
    );

    RegisterCardParams params = RegisterCardParams.prefilled(
       cardData: cardData,
       url: registerCardUrl
    );

    P24SDK.registerCard(params).then((value){
      setState(() => _sdkResult = value);
    });

  }

}