import 'package:flutter/material.dart';

class ImageProgressWidget extends StatelessWidget {
  const ImageProgressWidget({
    required this.size,
    Key? key,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
