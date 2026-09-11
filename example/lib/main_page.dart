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
  const MainPage({super.key});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const testMerchantId = 64195;
  static const testSandboxCrc = "d27e4cb580e9bbfe";
  static const testProductionCrc = "b36147eeac447028";

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
              const SizedBox(height: 16),
              _buildSdkConfigSection(),
              const SizedBox(height: 16),
              _buildSdkVersionSection(),
              const SizedBox(height: 16),
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

  Widget emptyWidgetIfNull(dynamic value, Widget Function() builder) {
    return value == null
        ? const SizedBox.shrink()
        : builder();
  }

  Widget _buildSdkVersionSection() {
    return SectionCard(
      title: "SdkVersion",
      widgets: <Widget>[
        FutureBuilder<String>(
          initialData: "",
          future: P24SDK.getSdkVersion(),
          builder: (context, snap) => emptyWidgetIfNull(snap.data, () => Text(snap.data!))
        )
      ],
    );
  }

  Widget _buildCheckboxOption(String label, bool isChecked, Function(bool) onChanged) {
    return SizedBox(
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
        ElevatedButton(onPressed: _showTrnRequestBottomSheet, child: const Text("Transfer TrnRequest")),
        ElevatedButton(onPressed: _showTrnDirectBottomSheet, child: const Text("Transfer TrnDirect")),
        ElevatedButton(onPressed: _showExpressBottomSheet, child: const Text("Transfer Express")),
        ElevatedButton(onPressed: _showPassageBottomSheet, child: const Text("Transfer Passage")),
        ElevatedButton(onPressed: _showRegisterCardBottomSheet, child: const Text("Register Card")),
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
      crc: _isSandboxEnabled ? testSandboxCrc : testProductionCrc,
      isSandboxEnabled: _isSandboxEnabled,
      merchantId: testMerchantId,
    ));

  }

  void _showExpressBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Express", (c) => const TransferExpressForm(
      merchantId: testMerchantId,
    ));
  }

  void _showPassageBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Passage", (c) => TransferPassageForm(
      crc: _isSandboxEnabled ? testSandboxCrc : testProductionCrc,
      isSandboxEnabled: _isSandboxEnabled,
      merchantId: testMerchantId,
    ));
  }

  void _showRegisterCardBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Register Card", (c) => const RegisterCardForm());
  }

  Widget _get3thPartWalletButton() {
    if(Platform.isAndroid) {
      return ElevatedButton(child: const Text("Google Pay"), onPressed: () => _showGooglePayBottomSheet());
    } else if(Platform.isIOS) {
      return ElevatedButton(child: const Text("Apple Pay"), onPressed: () => _showApplePayBottomSheet());
    } else {
      return const SizedBox.shrink();
    }
  }

  void _showGooglePayBottomSheet(){
    showFormDialog(_scaffoldKey.currentContext, "Google Pay", (c) => GooglePayForm(
      isSandboxEnabled: _isSandboxEnabled,
      merchantId: "GOOGLE_PAY_MERCHANT_ID",
    ));
  }

  void _showApplePayBottomSheet() {
    showFormDialog(_scaffoldKey.currentContext, "Apple Pay", (c) => ApplePayForm(
      isSandboxEnabled: _isSandboxEnabled
    ));
  }

}
