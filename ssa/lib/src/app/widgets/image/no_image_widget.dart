import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/strings/no_image_widget.constants.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({
    required this.size,
    Key? key,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).titleBackgroundColor,
      ),
      child: const Center(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            noImageWidgetMessage,
          ),
        ),
      ),
    );
  }
}
