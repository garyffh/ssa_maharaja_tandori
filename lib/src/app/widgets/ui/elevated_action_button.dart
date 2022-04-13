import 'package:flutter/material.dart';

class ElevatedActionButton extends StatelessWidget {
  const ElevatedActionButton({
    required this.onPressed,
    required this.text,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      onPressed: onPressed,
      label:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(text),
      ),
      icon: Icon(iconData),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
