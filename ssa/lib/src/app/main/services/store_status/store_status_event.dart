import 'package:single_store_app/src/app/models/business/store_status.dart';

abstract class StoreStatusEvent {}

class StoreStatusEventInitialise extends StoreStatusEvent {
  StoreStatusEventInitialise();
}

class StoreStatusEventRefresh extends StoreStatusEvent {
  StoreStatusEventRefresh();

}

class StoreStatusEventUpdate extends StoreStatusEvent {
  StoreStatusEventUpdate({
    required this.storeStatus,
    required this.timeZone,
});

  final StoreStatus storeStatus;
  final String timeZone;
}

class StoreStatusEventImmediateRefresh extends StoreStatusEvent {
  StoreStatusEventImmediateRefresh();

}
