import 'package:flutter/material.dart';

class BaseModalFormToolbar extends StatelessWidget {

  final String title;

  const BaseModalFormToolbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => Navigator.pop(context)
      ),
    );
  }
}