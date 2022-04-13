
import 'package:json_annotation/json_annotation.dart';

part 'store_state.g.dart';

@JsonSerializable()
class StoreState {

  StoreState({
    required this.storeAvailable,
    required this.deliveryAvailable,
    required this.manualStoreOnline,
    required this.manualDeliveryOnline,
    required this.storeOnline,
    required this.driverAvailable,
    required this.storePrepTime,
    required this.storeLiveTime,
    required this.driverDeliveryTime,
    required this.driverLiveTime,
    required this.messageTitle,
    required this.message,
  });

  factory StoreState.fromJson(Map<String, dynamic> json) =>
      _$StoreStateFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStateToJson(this);

  final bool storeAvailable;
  final bool deliveryAvailable;
  final bool manualStoreOnline;
  final bool manualDeliveryOnline;
  final bool storeOnline;

  final bool driverAvailable;
  final int storePrepTime;
  final int storeLiveTime;
  final int driverDeliveryTime;
  final int driverLiveTime;
  final String messageTitle;
  final String message;

}
