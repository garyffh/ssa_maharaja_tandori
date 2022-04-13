import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'delivery_method_control_state.dart';

class DeliveryMethodControlStates {
  const DeliveryMethodControlStates({
    required this.deliveryMethodStates,
    required this.activeDeliveryMethodStates,
  });

  DeliveryMethodControlStates.empty()
      : deliveryMethodStates = List.empty(),
        activeDeliveryMethodStates = List.empty();

  DeliveryMethodControlStates.fromDeliveryMethodTypes(
      List<DeliveryMethodType> activeDeliveryMethodTypes)
      : deliveryMethodStates =
            itemsFromDeliveryMethodTypes(activeDeliveryMethodTypes),
        activeDeliveryMethodStates = getActiveDeliveryMethodStates(
            itemsFromDeliveryMethodTypes(activeDeliveryMethodTypes));

  final List<DeliveryMethodControlState> deliveryMethodStates;
  final List<DeliveryMethodControlState> activeDeliveryMethodStates;

  static List<DeliveryMethodControlState> itemsFromDeliveryMethodTypes(
      List<DeliveryMethodType> activeDeliveryMethodTypes) {
    return List<DeliveryMethodControlState>.generate(
        DeliveryMethodType.values.length,
        (int index) => DeliveryMethodControlState(
              deliveryMethodType: DeliveryMethodType.values[index],
              isActive: activeDeliveryMethodTypes
                  .contains(DeliveryMethodType.values[index]),
            ));
  }

  static List<DeliveryMethodControlState> getActiveDeliveryMethodStates(
      List<DeliveryMethodControlState> deliveryMethodStates) {
    return deliveryMethodStates.where((element) => element.isActive).toList();
  }
}
