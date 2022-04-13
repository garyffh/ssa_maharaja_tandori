import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({
    required this.iconData,
    required this.value,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final double value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Icon(iconData),
          if (value != 0.0)
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  Formats.qty(value),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
        ],
      ),
    );
  }
}
