import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

class DeliveryMethodControlState  {
  const DeliveryMethodControlState({
    required this.deliveryMethodType,
    required this.isActive,
});

  final DeliveryMethodType deliveryMethodType;
  final bool isActive;

}
