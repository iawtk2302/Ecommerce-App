import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class MyBodyScaffold extends StatelessWidget {
  const MyBodyScaffold({super.key, required this.widgets});
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        return widgets[index];
      },
    );
  }
}
