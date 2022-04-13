import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';

abstract class CartEvent {}

class CartEventLoadFromStore extends CartEvent {
  CartEventLoadFromStore();

}

class CartEventUserBusinessUpdate extends CartEvent {
  CartEventUserBusinessUpdate();

}

class CartEventViewCart extends CartEvent {
  CartEventViewCart();

}

class CartEventGetCartActiveItem extends CartEvent {
  CartEventGetCartActiveItem({
    required this.sitem,
  });

  final Sitem sitem;
}


class CartEventAdd extends CartEvent {
  CartEventAdd({
    required this.cartActiveItem,
});

  final CartActiveItem cartActiveItem;

}

class CartEventGetUpdateCartActiveItem extends CartEvent {
  CartEventGetUpdateCartActiveItem({
    required this.updateIndex,
  });

  final int updateIndex;
}

class CartEventUpdate extends CartEvent {
  CartEventUpdate({
    required this.cartActiveItem,
    required this.updateIndex,
  });

  final CartActiveItem cartActiveItem;
  final int updateIndex;

}

class CartEventDelete extends CartEvent {
  CartEventDelete({
    required this.updateIndex,
  });

  final int updateIndex;

}

class CartEventEmpty extends CartEvent {
  CartEventEmpty();

}

class CartEventReset extends CartEvent {
  CartEventReset();

}
