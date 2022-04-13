enum CartNavAction {
  initialise,
  closeCartAdd,
  closeCartUpdate,
}

abstract class CartNavState {
  CartNavState({required this.cartNavAction});

  final CartNavAction cartNavAction;
}

class CartNavStateInitialise extends CartNavState {
  CartNavStateInitialise() : super(cartNavAction: CartNavAction.initialise);
}

class CartNavStateCloseCartAdd extends CartNavState {
  CartNavStateCloseCartAdd() : super(cartNavAction: CartNavAction.closeCartAdd);
}

class CartNavStateCloseCartUpdate extends CartNavState {
  CartNavStateCloseCartUpdate()
      : super(cartNavAction: CartNavAction.closeCartUpdate);
}
