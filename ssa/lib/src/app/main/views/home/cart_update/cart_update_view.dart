import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_event.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_state.dart';
import 'package:single_store_app/src/app/main/services/cart_nav/cart_nav_cubit.dart';
import 'package:single_store_app/src/app/main/services/cart_nav/cart_nav_state.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/cart_active_item_update.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/cart_active_item_update_type.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view_scroll.dart';

class CartUpdateView extends StatefulWidget {
  const CartUpdateView({
    required this.updateIndex,
    Key? key,
  }) : super(key: key);

  final int updateIndex;

  @override
  State<CartUpdateView> createState() => _CartUpdateViewState();
}

class _CartUpdateViewState extends State<CartUpdateView> {
  bool _initialised = false;
  late CartBloc cartBloc;

  @override
  void didChangeDependencies() {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    if (!_initialised) {
      _initialised = true;
      this.cartBloc = cartBloc;
      _initialise();
    } else {
      if (this.cartBloc != cartBloc) {
        this.cartBloc = cartBloc;
        _initialise();
      }
    }

    super.didChangeDependencies();
  }

  void _initialise() {
    cartBloc
        .add(CartEventGetUpdateCartActiveItem(updateIndex: widget.updateIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartNavCubit, CartNavState>(
      listener: (cartNavContext, cartNavState) {
        if (cartNavState.cartNavAction == CartNavAction.closeCartUpdate) {
          context.read<HomeNavCubit>().showCartDisplay();
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (viewContext, state) {
          return PrimaryViewScroll(
            title: _title(state),
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  String _title(CartState state) {
    if(state is CartStateViewModel) {
      if(state.cartActiveItem == null) {
        return 'Cart Update';
      } else {
        return state.cartActiveItem!.name;
      }
    } else {
      return 'Cart Update';
    }
  }
  Widget _view(BuildContext viewContext, CartState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(viewContext, viewState as CartStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return SingleChildScrollView(
              child: ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => cartBloc.add(
                CartEventGetUpdateCartActiveItem(
                    updateIndex: widget.updateIndex)),
              ),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return SingleChildScrollView(
              child: ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () => cartBloc.add(
                CartEventGetUpdateCartActiveItem(
                    updateIndex: widget.updateIndex)),
          ),);
        }

      case ProgressErrorStateType.submitted:
      case ProgressErrorStateType.idle:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    CartStateViewModel viewModel,
  ) {
    if (viewModel.cartActiveItem == null) {
      return SingleChildScrollView(
        child: ProgressErrorWidget(
          progressErrorState: viewModel,
          dataDirection: DataDirection.receiving,
          tryAgainCallback: () => cartBloc.add(CartEventGetUpdateCartActiveItem(
              updateIndex: widget.updateIndex)),
        ),
      );
    } else {
      return CartActiveItemUpdate(
        cartActiveItemUpdateType: CartActiveItemUpdateType.updateItemView,
        progressErrorStateType: viewModel.type,
        cartActiveItem: viewModel.cartActiveItem!,
        updateIndex: widget.updateIndex,
      );
    }
  }
}
