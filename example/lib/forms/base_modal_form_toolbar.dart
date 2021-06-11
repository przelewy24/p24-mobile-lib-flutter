import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseModalFormToolbar extends StatelessWidget {

  final String title;

  BaseModalFormToolbar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => Navigator.pop(context)
      ),
    );
  }
}