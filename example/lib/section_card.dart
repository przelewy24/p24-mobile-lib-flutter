import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {

  final String title;
  final List<Widget> widgets;


  const SectionCard({super.key, required this.title, required this.widgets});

  @override
  Widget build(BuildContext context) {
   return Card(
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Text(title, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
           const SizedBox(height: 8),
           Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: widgets)
         ],
       ),
     ),
   );
  }
}