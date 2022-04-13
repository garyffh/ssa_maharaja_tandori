import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/cart/cart.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';

@immutable
abstract class CartState extends ProgressErrorState {
  const CartState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

  double get itemCount => 0;

}

class CartStateInitial extends CartState {
  const CartStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class CartStateLoadingError extends CartState {
  const CartStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

abstract class CartStateViewModel extends CartState {
  const CartStateViewModel({
    required this.cart,
    required this.cartActiveItem,
    required this.updateIndex,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
    error: error,
    type: type,
  );

  final Cart cart;
  final CartActiveItem? cartActiveItem;
  final int? updateIndex;

  @override
  double get itemCount => cart.cartTotals.qty;

}

class CartStateViewProgressError extends CartStateViewModel {
  const CartStateViewProgressError({
    required Cart cart,
    required CartActiveItem? cartActiveItem,
    required int? updateIndex,
    dynamic error,
  }) : super(
    cart: cart,
    cartActiveItem: cartActiveItem,
    updateIndex: updateIndex,
    type: ProgressErrorStateType.progressError,
    error: error,
  );

}

class CartStateViewLoaded extends CartStateViewModel {
  const CartStateViewLoaded({
    required Cart cart,
    required CartActiveItem? cartActiveItem,
    required int? updateIndex,
  }) : super(
    cart: cart,
    cartActiveItem: cartActiveItem,
    updateIndex: updateIndex,
    type: ProgressErrorStateType.loaded,

  );

}

