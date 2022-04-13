import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:single_store_app/src/app/constants/strings/image_error_widget.constants.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({
    required this.size,
    this.error,
    Key? key,
  }) : super(key: key);

  final Size size;
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    String message = errorUnknownMessage;

    if (error.runtimeType == HttpExceptionWithStatus) {
      switch ((error as HttpExceptionWithStatus).statusCode) {
        case 404:
          message = error404Message;
          break;
      }
    }

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(border: Border.all()),
      child: Center(
        child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          message,
        ),
        ),
      ),
    );
  }
}
