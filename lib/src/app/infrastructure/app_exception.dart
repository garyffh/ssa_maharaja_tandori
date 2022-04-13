import 'package:single_store_app/src/app/constants/strings/app_repo.constants.dart';

class AppException implements Exception {
  AppException({
    required this.message,
  });

  AppException.fromString(String value)
      : message = [value];

  AppException.unknownHttpResponse(int statusCode)
      : message = [errorUnknown, 'STATUS CODE: $statusCode'];

  final List<String> message;

  @override
  String toString() {
    return message.join('\n');
  }
}
