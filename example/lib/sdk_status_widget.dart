import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:p24_sdk/p24_sdk.dart';

class SdkStatusWidget extends StatefulWidget {

  final SdkResult? sdkResult;
  final String prefix;

  SdkStatusWidget({required this.sdkResult, required this.prefix});

  @override
  _SdkStatusWidgetState createState() => _SdkStatusWidgetState();

}

class _SdkStatusWidgetState extends State<SdkStatusWidget> {

  Color _statusColor = Colors.transparent;
  String _message = "";

  @override
  Widget build(BuildContext context) {
      _checkSdkResult(widget.sdkResult);
      return _statusWidget();
  }

  Widget _statusWidget() {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Status",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8,),
          Expanded(
            child: Container(
              color: _statusColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateStatusSection({required Color color, required String message}) {
    setState(() {
      _statusColor = color;
      _message = message;
    });
  }

  void _checkSdkResult(SdkResult? value) {
    switch (value?.status) {
      case SdkStatus.success:
        _updateStatusSection(color: Colors.green, message: "${widget.prefix}: success, ${value?.payload ?? ""}");
        break;
      case SdkStatus.error:
        _updateStatusSection(color: Colors.red, message: "${widget.prefix}: error, ${value?.payload ?? ""}");
        break;
      default:
        _updateStatusSection(color: Colors.orange, message: "${widget.prefix}: cancel");
        break;
    }
  }

}