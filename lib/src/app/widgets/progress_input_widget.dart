import 'package:flutter/material.dart';

class ProgressInputWidgetNotUsed extends StatelessWidget {
  const ProgressInputWidgetNotUsed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
