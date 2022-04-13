import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    required this.buttonText,
    required this.onPressed,
    Key? key
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    return  ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(
        buttonText,
      ),
    );
  }
}
