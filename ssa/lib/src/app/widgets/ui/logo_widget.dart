import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({this.boxConstraints, Key? key}) : super(key: key);

  final BoxConstraints? boxConstraints;

  @override
  Widget build(BuildContext context) {
    return boxConstraints == null
        ?  Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Color(
                    PackageConstants.logoBackgroundColour),
              ),
              child: Image.asset(
                'assets/icons/logo.png',
                fit: BoxFit.contain,
              ),
          )
        : Container(
            padding: const EdgeInsets.all(8.0),
            constraints: boxConstraints,
            decoration: const BoxDecoration(
              color: Color(
                  PackageConstants.logoBackgroundColour),
            ),
            child: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.contain,
            ),
          );
  }
}
