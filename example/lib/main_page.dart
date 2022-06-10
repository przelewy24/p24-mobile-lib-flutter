import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:p24_sdk_example/forms/apple_pay_form.dart';
import 'package:p24_sdk_example/forms/base_form_modal.dart';
import 'package:p24_sdk_example/forms/google_pay_form.dart';
import 'package:p24_sdk_example/forms/register_card_form.dart';
import 'package:p24_sdk_example/forms/transfer_express_form.dart';
import 'package:p24_sdk_example/forms/transfer_passage_form.dart';
import 'package:p24_sdk_example/forms/trn_direct_form.dart';
import 'package:p24_sdk_example/forms/trn_request_form.dart';
import 'package:p24_sdk_example/section_card.dart';

import 'package:p24_sdk/p24_sdk.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const TEST_MERCHANT_ID = 64195;
  static const TEST_SANDBOX_CRC = "d27e4cb580e9bbfe";
  static const TEST_PRODUCTION_CRC = "b36147eeac447028";

  bool _isSandboxEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('P24Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildEnvironmentSection(),
              SizedBox(height: 16),
              _buildSdkConfigSection(),
              SizedBox(height: 16),
              _buildSdkVersionSection(),
              SizedBox(height: 16),
              _buildMethodsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnvironmentSection() {
    return SectionCard(
      title: "Environment",
      widgets: <Widget>[
        _buildCheckboxOption("Sandbox", _isSandboxEnabled, (value) => setState(() => _isSandboxEnabled = value)),
        _buildCheckboxOption("Secure", !_isSandboxEnabled, (value) => setState(() => _isSandboxEnabled = !value)),
      ],
    );
  }

  Widget _buildSdkConfigSection() {
    return SectionCard(
      title: "SdkConfig",
      widgets: <Widget>[
        FutureBuilder<bool>(
          initialData: false,
          future: SdkConfig.getCertificatePinningEnabled(),
          builder: (context, snap) => emptyWidgetIfNull(snap.data, () => _buildCheckboxOption(
            "SSL Pinning", snap.data!, (value) async {
              await SdkConfig.setCertificatePinningEnabled(value);
              setState((){});// rebuild to load new value
            })
          )
        ),
        FutureBuilder<bool>(
          initialData: false,
          future: SdkConfig.getFinishOnBackButtonEnabled(),
          builder: (context, snap) => emptyWidgetIfNull(snap.data, () => _buildCheckboxOption(
              "Finish on back button", snap.data!, (value) async {
              await SdkConfig.setFinishOnBackButtonEnabled(value);
              setState((){});// rebuild to load new value
            })
          )
        ),
        FutureBuilder<bool>(
          initialData: false,
          future: SdkConfig.getSplitPaymentEnabled(),
          builder: (context, snap) => emptyWidgetIfNull(snap.data, () => _buildCheckboxOption(
              "Split payment", snap.data!, (value) async {
            await SdkConfig.setSplitPaymentEnabled(value);
            setState((){});// rebuild to load new value
          })
          )
        )
      ],
    );
  }

  Widget emptyWidgetIfNull(dynamic value, Widget builder()) {
    return value == null
        ? SizedBox.shrink()
        : builder();
  }

  Widget _buildSdkVersionSection() {
    return SectionCard(
      title: "SdkVersion",
      widgets: <Widget>[
        FutureBuilder<String>(
          initialData: "",
          future: P24SdkVersion.value(),
          builder: (context, snap) => emptyWidgetIfNull(snap.data, () => Text(snap.data!))
        )
      ],
    );
  }

  Widget _buildCheckboxOption(String label, bool isChecked, Function(bool) onChanged) {
    return Container(
      height: 32,
      child: Row(
        children: <Widget>[
          SizedBox(width: 24, height: 24, child: Checkbox(value: isChecked, onChanged: (value) => {
            if(value != null){
              onChanged(value)
            }
          })),
          Container(width: 8),
          Text(label)
        ],
      ),
    );
  }

  Widget _buildMethodsSection() {
    return SectionCard(
      title: "Actions",
      widgets: <Widget>[
        ElevatedButton(child: Text("Transfer TrnRequest"), onPressed: _showTrnRequestBottomSheet),
        ElevatedButton(child: Text("Transfer TrnDirect"), onPressed: _showTrnDirectBottomSheet),
        ElevatedButton(child: Text("Transfer Express"), onPressed: _showExpressBottomSheet),
        ElevatedButton(child: Text("Transfer Passage"), onPressed: _showPassageBottomSheet),
        ElevatedButton(child: Text("Register Card"), onPressed: _showRegisterCardBottomSheet),
        _get3thPartWalletButton()
      ],
    );
  }

  void _showTrnRequestBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "TrnRequest", (c) => TrnRequestForm(
      isSandboxEnabled: _isSandboxEnabled,
    ));
  }

  void _showTrnDirectBottomSheet() async {
    showFormDialog(_scaffoldKey.currentContext, "TrnDirect", (c) => TrnDirectForm(
      crc: _isSandboxEnabled ? TEST_SANDBOX_CRC : TEST_PRODUCTION_CRC,
      isSandboxEnabled: _isSandboxEnabled,
      merchantId: TEST_MERCHANT_ID,
    ));

  }

  void _showExpressBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Express", (c) => TransferExpressForm(
      merchantId: TEST_MERCHANT_ID,
    ));
  }

  void _showPassageBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Passage", (c) => TransferPassageForm(
      crc: _isSandboxEnabled ? TEST_SANDBOX_CRC : TEST_PRODUCTION_CRC,
      isSandboxEnabled: _isSandboxEnabled,
      merchantId: TEST_MERCHANT_ID,
    ));
  }

  void _showRegisterCardBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Register Card", (c) => RegisterCardForm());
  }

  Widget _get3thPartWalletButton() {
    if(Platform.isAndroid) {
      return ElevatedButton(child: Text("Google Pay"), onPressed: () => _showGooglePayBottomSheet());
    } else if(Platform.isIOS) {
      return ElevatedButton(child: Text("Apple Pay"), onPressed: () => _showApplePayBottomSheet());
    } else {
      return SizedBox.shrink();
    }
  }

  void _showGooglePayBottomSheet(){
    showFormDialog(_scaffoldKey.currentContext, "Google Pay", (c) => GooglePayForm(
      isSandboxEnabled: _isSandboxEnabled,
      merchantId: TEST_MERCHANT_ID,
    ));
  }

  void _showApplePayBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Apple Pay", (c) => ApplePayForm(
      isSandboxEnabled: _isSandboxEnabled
    ));
  }

}
