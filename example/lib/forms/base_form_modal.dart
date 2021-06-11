import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:p24_sdk_example/forms/base_modal_form_toolbar.dart';

class BaseFormModal extends StatelessWidget {

  final String title;
  final WidgetBuilder builder;

  const BaseFormModal({required this.title, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BaseModalFormToolbar(title: title),
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: builder(context)
              ),
            ]
          ),
        ),
      ),
    );
  }

}

void showFormDialog(BuildContext? context, String title, WidgetBuilder builder) {
  if(context != null) {
    showDialog(context: context, builder: (c) => Dialog(
      child: BaseFormModal(title: title, builder: builder),
    ));
  }
}