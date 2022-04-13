import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/models/infrastructure/dialog_message.dart';

enum OpenStatus {
  @JsonValue(0)
  open,
  @JsonValue(1)
  offline,
  @JsonValue(2)
  closed,
  @JsonValue(3)
  openingSoon
}


extension OpenStatusExtension on OpenStatus {

  DialogMessage get dialogMessage {
    switch(this) {

      case OpenStatus.open:
        return DialogMessage(title: 'Open', content: 'The store is open!');

      case OpenStatus.offline:
        return DialogMessage(title: 'Offline', content: AppConstants.deliveryOfflineMessage);

      case OpenStatus.closed:
        return DialogMessage(title: 'Closed', content: AppConstants.cartClosedMessage);

      case OpenStatus.openingSoon:
        return DialogMessage(title: 'Closed', content: AppConstants.openingSoonMessage);

    }
  }
}
