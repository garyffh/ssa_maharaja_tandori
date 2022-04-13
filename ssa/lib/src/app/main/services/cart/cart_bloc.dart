import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/cart_repo.dart';
import 'package:single_store_app/src/app/main/services/cart_nav/cart_nav_cubit.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_bloc.dart';
import 'package:single_store_app/src/app/models/cart/cart.dart';
import 'package:single_store_app/src/app/models/cart/cart_active.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_chain.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/cart/cart_store.dart';
import 'package:single_store_app/src/app/models/cart/cart_store_item.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required this.appFloatingButtonCubit,
    required this.cartNavCubit,
    required this.storageCubit,
    required this.cartRepo,
    required this.userBusinessBloc,
  }) : super(const CartStateInitial()) {
    on<CartEventLoadFromStore>((event, emit) async {
      /// ------- LOAD CART BEGIN ---------
      try {
        emit(const CartStateLoadingError());

        emit(CartStateViewLoaded(
          cart: Cart.update(cartActive: await loadCartActiveFromStore()),
          cartActiveItem: null,
          updateIndex: null,
        ));
      } catch (e) {
        emit(CartStateLoadingError(error: e));
      }

      /// ------- LOAD CART END -----------
    });

    on<CartEventViewCart>((event, emit) async {

      /// ------- LOAD CART BEGIN ---------

      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());
          appFloatingButtonCubit.removeFloatingButton();

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------
    });

    on<CartEventUserBusinessUpdate>((event, emit) async {
      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: cartStateViewModel.cartActiveItem,
          updateIndex: cartStateViewModel.updateIndex,
        ));

        final CartActive updatedCartActive = CartActive.priceLevelUpdate(
          priceLevel: userBusinessBloc.state.priceLevel,
          cartActive: cartStateViewModel.cart.cartActive,
        );

        await storageCubit
            .saveCart(CartStore.fromCartActive(updatedCartActive));

        emit(CartStateViewLoaded(
          cart: Cart.update(
            cartActive: updatedCartActive,
          ),
          cartActiveItem: (cartStateViewModel.cartActiveItem == null)
              ? null
              : CartActiveItem.update(
                  priceLevel: userBusinessBloc.state.priceLevel,
                  cartActiveItem: cartStateViewModel.cartActiveItem!),
          updateIndex: cartStateViewModel.updateIndex,
        ));
      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: cartStateViewModel.cartActiveItem,
          updateIndex: cartStateViewModel.updateIndex,
          error: e,
        ));
      }
    });

    on<CartEventGetCartActiveItem>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());
          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {

        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
        ));

        late CartActiveItem cartActiveItem;

        if (event.sitem.hasCondimentChain) {
          cartActiveItem = CartActiveItem.fromSitem(
            qty: 1.0,
            priceLevel: userBusinessBloc.state.priceLevel,
            sitem: event.sitem,
            cartActiveChain: CartActiveChain.fromCondimentChain(
              qty: 1.0,
              priceLevel: userBusinessBloc.state.priceLevel,
              condimentChain: await cartRepo.findCondimentChain(
                  sysCondimentChainId: event.sitem.sysCondimentChainId!),
            ),
          );
        } else if (event.sitem.hasCondimentTable) {
          cartActiveItem = CartActiveItem.fromSitem(
            qty: 1.0,
            priceLevel: userBusinessBloc.state.priceLevel,
            sitem: event.sitem,
            cartActiveChain: CartActiveChain.fromCondimentTable(
              qty: 1.0,
              priceLevel: userBusinessBloc.state.priceLevel,
              condimentTable: await cartRepo.findCondimentTable(
                  sysCondimentTableId: event.sitem.sysCondimentTableId!),
            ),
          );
        } else {
          cartActiveItem = CartActiveItem.fromSitem(
            qty: 1.0,
            priceLevel: userBusinessBloc.state.priceLevel,
            sitem: event.sitem,
            cartActiveChain: null,
          );
        }

        emit(CartStateViewLoaded(
          cart: cartStateViewModel.cart,
          cartActiveItem: cartActiveItem,
          updateIndex: null,
        ));
      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
          error: e,
        ));
      }
    });

    on<CartEventAdd>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: cartStateViewModel.cartActiveItem,
          updateIndex: null,
        ));

        cartStateViewModel.cart.cartActive.items.add(event.cartActiveItem);

        await storageCubit.saveCart(
            CartStore.fromCartActive(cartStateViewModel.cart.cartActive));

        emit(CartStateViewLoaded(
          cart: Cart.update(cartActive: cartStateViewModel.cart.cartActive),
          cartActiveItem: null,
          updateIndex: null,
        ));

        cartNavCubit.closeCartAdd();
      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: event.cartActiveItem,
          updateIndex: null,
          error: e,
        ));
      }
    });

    on<CartEventGetUpdateCartActiveItem>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {

        emit(CartStateViewLoaded(
          cart: cartStateViewModel.cart,
          cartActiveItem: CartActiveItem.copy(
              cartStateViewModel.cart.cartActive.items[event.updateIndex]),
          updateIndex: event.updateIndex,
        ));
      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
          error: e,
        ));
      }
    });

    on<CartEventUpdate>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      if (cartStateViewModel.updateIndex == null) {
        throw AppException.fromString('Update index is null');
      }

      try {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: cartStateViewModel.cartActiveItem,
          updateIndex: cartStateViewModel.updateIndex,
        ));

        cartStateViewModel.cart.cartActive
            .items[cartStateViewModel.updateIndex!] = event.cartActiveItem;

        await storageCubit.saveCart(
            CartStore.fromCartActive(cartStateViewModel.cart.cartActive));

        emit(CartStateViewLoaded(
          cart: Cart.update(cartActive: cartStateViewModel.cart.cartActive),
          cartActiveItem: null,
          updateIndex: null,
        ));

        cartNavCubit.closeCartUpdate();
      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: cartStateViewModel.cartActiveItem,
          updateIndex: cartStateViewModel.updateIndex,
          error: e,
        ));
      }
    });

    on<CartEventDelete>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
        ));

        cartStateViewModel.cart.cartActive.items.removeAt(event.updateIndex);

        await storageCubit.saveCart(
            CartStore.fromCartActive(cartStateViewModel.cart.cartActive));

        emit(CartStateViewLoaded(
          cart: Cart.update(cartActive: cartStateViewModel.cart.cartActive),
          cartActiveItem: null,
          updateIndex: null,
        ));

        cartNavCubit.closeCartAdd();
      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
          error: e,
        ));
      }
    });


    on<CartEventEmpty>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {

        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
        ));

        cartStateViewModel.cart.cartActive.items.clear();

        await storageCubit.saveCart(
            CartStore.fromCartActive(cartStateViewModel.cart.cartActive));

        emit(CartStateViewLoaded(
          cart: Cart.update(cartActive: cartStateViewModel.cart.cartActive),
          cartActiveItem: null,
          updateIndex: null,
        ));

      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
          error: e,
        ));
      }
    });

    on<CartEventReset>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      /// ------- LOAD CART BEGIN ---------
      if (state is! CartStateViewModel) {
        try {
          emit(const CartStateLoadingError());

          emit(CartStateViewLoaded(
            cart: Cart.update(cartActive: await loadCartActiveFromStore()),
            cartActiveItem: null,
            updateIndex: null,
          ));
        } catch (e) {
          emit(CartStateLoadingError(error: e));
        }
      }

      /// ------- LOAD CART END -----------

      if (state is! CartStateViewModel) {
        return;
      }

      final CartStateViewModel cartStateViewModel = state as CartStateViewModel;

      try {

        cartStateViewModel.cart.cartActive.items.clear();

        await storageCubit.saveCart(
            CartStore.fromCartActive(cartStateViewModel.cart.cartActive));

        emit(CartStateViewLoaded(
          cart: Cart.update(cartActive: cartStateViewModel.cart.cartActive),
          cartActiveItem: null,
          updateIndex: null,
        ));

      } catch (e) {
        emit(CartStateViewProgressError(
          cart: cartStateViewModel.cart,
          cartActiveItem: null,
          updateIndex: null,
          error: e,
        ));
      }
    });



    userBusinessBlocSubscription = userBusinessBloc.stream.listen((state) {
      add(CartEventUserBusinessUpdate());
    });

  }

  final AppFloatingButtonCubit appFloatingButtonCubit;
  final CartNavCubit cartNavCubit;
  final StorageCubit storageCubit;
  final CartRepo cartRepo;
  final UserBusinessBloc userBusinessBloc;
  late StreamSubscription userBusinessBlocSubscription;

  Future<CartActive> loadCartActiveFromStore() async {
    final CartStore cartStore = await storageCubit.getCart();

    final List<CartActiveItem> cartActiveItems = List.empty(growable: true);
    for (final CartStoreItem cartStoreItem in cartStore.items) {
      final CartActiveItem? cartActiveItem =
          await cartActiveItemFromCartStoreItem(cartStoreItem);
      if (cartActiveItem != null) {
        cartActiveItems.add(cartActiveItem);
      }
    }

    return CartActive(
      priceLevel: userBusinessBloc.state.priceLevel,
      items: cartActiveItems,
    );
  }

  Future<CartActiveItem?> cartActiveItemFromCartStoreItem(
      CartStoreItem cartStoreItem) async {
    try {
      final Sitem sitem = Sitem.fromSitemDetail(
          await cartRepo.findSitemDetail(sysSitemId: cartStoreItem.sysSitemId));

      late CartActiveItem rtn;
      if (sitem.hasCondimentChain) {
        rtn = CartActiveItem.fromSitem(
          qty: cartStoreItem.qty,
          priceLevel: userBusinessBloc.state.priceLevel,
          instructions: cartStoreItem.instructions,
          sitem: sitem,
          cartActiveChain: CartActiveChain.fromCondimentChain(
            qty: cartStoreItem.qty,
            priceLevel: userBusinessBloc.state.priceLevel,
            condimentChain: await cartRepo.findCondimentChain(
                sysCondimentChainId: sitem.sysCondimentChainId!),
          ),
        );
      } else if (sitem.hasCondimentTable) {
        rtn = CartActiveItem.fromSitem(
          qty: cartStoreItem.qty,
          priceLevel: userBusinessBloc.state.priceLevel,
          instructions: cartStoreItem.instructions,
          sitem: sitem,
          cartActiveChain: CartActiveChain.fromCondimentTable(
            qty: cartStoreItem.qty,
            priceLevel: userBusinessBloc.state.priceLevel,
            condimentTable: await cartRepo.findCondimentTable(
                sysCondimentTableId: sitem.sysCondimentTableId!),
          ),
        );
      } else {
        rtn = CartActiveItem.fromSitem(
          qty: cartStoreItem.qty,
          priceLevel: userBusinessBloc.state.priceLevel,
          instructions: cartStoreItem.instructions,
          sitem: sitem,
          cartActiveChain: null,
        );
      }

      if (cartStoreItem.cartStoreChain != null) {
        rtn.setStoreSelectedItems(cartStoreItem.cartStoreChain!.items);
      }

      return rtn;
    } catch (_) {
      /// ignore error
      return null;
    }
  }

  @override
  Future<void> close() {
    userBusinessBlocSubscription.cancel();
    return super.close();
  }
}
