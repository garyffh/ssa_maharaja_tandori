import 'package:single_store_app/src/app/constants/strings/data_direction.constants.dart';

enum DataDirection {
  none,
  sending,
  receiving,
}

extension DataDirectionExtension on DataDirection {

  String get text {
    switch(this) {

      case DataDirection.none:
        return dataDirectionNoneText;

      case DataDirection.sending:
        return dataDirectionSendingText;

      case DataDirection.receiving:
        return dataDirectionReceivingText;

    }
  }
}

