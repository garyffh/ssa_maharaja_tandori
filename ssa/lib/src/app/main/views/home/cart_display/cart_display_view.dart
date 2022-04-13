import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_event.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_state.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/column_builder.dart';
import 'package:single_store_app/src/app/widgets/ui/confirmation_dialog.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/title_action_button.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

class CartDisplayView extends StatefulWidget {
  const CartDisplayView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartDisplayViewState();
}

class _CartDisplayViewState extends State<CartDisplayView> {
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
    cartBloc.add(CartEventViewCart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (viewContext, state) {
        return Column(
          children: [
            ViewTitleWidget(
                title: 'Cart ${_cartTotalText(context, state)}',
                trailingWidget: state.itemCount == 0
                    ? null
                    : TitleActionButton(
                        label: 'REMOVE ALL',
                        iconData: Icons.remove_shopping_cart,
                        onPressed: () =>
                            _showEmptyCartConfirmationDialog(viewContext),
                      )),
            Expanded(
              child: _view(viewContext, state),
            ),
          ],
        );
      },
    );
  }

  String _cartTotalText(BuildContext context, CartState state) {
    if (state is CartStateViewModel) {
      return state.cart.cartTotals.total == 0
          ? ''
          : ' ${Formats.currency(state.cart.cartTotals.total)}';
    } else {
      return '';
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
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => cartBloc.add(CartEventViewCart()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => cartBloc.add(CartEventLoadFromStore()),
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    CartStateViewModel viewModel,
  ) {
    return viewModel.cart.cartActive.items.isEmpty
        ? const EmptyListWidget(label: 'No Items In Your Cart!')
        : _cartView(viewContext, viewModel);
  }

  Widget _cartView(
    BuildContext viewContext,
    CartStateViewModel viewModel,
  ) {
    if (!viewContext.read<StoreStatusBloc>().state.closed) {
      viewContext.read<AppFloatingButtonCubit>().showFloatingButton(
            floatingActionButton: _checkoutButton(viewContext),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth:
                      viewContext.read<MediaSettingsBloc>().state.lgWidthSize),
              child: ColumnBuilder(
                itemCount: viewModel.cart.cartActive.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return _cartItemView(viewContext,
                      viewModel.cart.cartActive.items[index], index);
                },
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth:
                      viewContext.read<MediaSettingsBloc>().state.lgWidthSize),
              child: const SizedBox(height: 75.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartItemView(
    BuildContext viewContext,
    CartActiveItem item,
    int index,
  ) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: Theme.of(viewContext).textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      color: Theme.of(viewContext).iconTheme.color,
                      iconSize:
                          viewContext.watch<MediaSettingsBloc>().state.sp20,
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () => _showDeleteConfirmationDialog(
                          viewContext, item, index),
                    ),
                    IconButton(
                      color: Theme.of(viewContext).iconTheme.color,
                      iconSize:
                          viewContext.watch<MediaSettingsBloc>().state.sp20,
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () => viewContext
                          .read<HomeNavCubit>()
                          .showCartUpdate(index),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Qty',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          Formats.qty(item.qty),
                          style: Theme.of(viewContext).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          Formats.currency(item.price),
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          constraints: const BoxConstraints(minWidth: 70.0),
                          child: Text(
                            Formats.currency(item.total),
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (item.cartActiveChain != null)
                _cartChainView(viewContext, item.cartActiveChain!.items),
              if (item.instructions != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 30.0),
                      Expanded(
                        child: Text(
                          item.instructions!,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartChainView(
    BuildContext viewContext,
    List<CartCondimentTable> cartCondimentTables,
  ) {
    return ColumnBuilder(
      itemCount: cartCondimentTables.length,
      itemBuilder: (BuildContext context, int index) {
        return _cartCondimentTableView(viewContext, cartCondimentTables[index]);
      },
    );
  }

  Widget _cartCondimentTableView(
    BuildContext viewContext,
    CartCondimentTable cartCondimentTable,
  ) {
    return ColumnBuilder(
      itemCount: cartCondimentTable.selectedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const SizedBox(width: 30.0),
              Expanded(
                child: Text(
                  cartCondimentTable.selectedItems[index].name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(width: 10.0),
              if (cartCondimentTable.selectedItems[index].price == 0)
                const SizedBox.shrink()
              else
                Text(
                  Formats.currency(
                      cartCondimentTable.selectedItems[index].price),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              const SizedBox(width: 10.0),
              Container(
                constraints: const BoxConstraints(minWidth: 70.0),
                child: cartCondimentTable.selectedItems[index].total == 0
                    ? const SizedBox.shrink()
                    : Text(
                        Formats.currency(
                            cartCondimentTable.selectedItems[index].total),
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  FloatingActionButton _checkoutButton(
    BuildContext viewContext,
  ) {
    return FloatingActionButton.extended(
      onPressed: () {
        viewContext.read<HomeNavCubit>().showCheckout();
      },
      label: const Text('CHECKOUT'),
      icon: const Icon(Icons.shopping_bag),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext viewContext,
    CartActiveItem item,
    int index,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Remove ${item.name}',
              content: 'Confirm removing the item from the cart.',
              onConfirm: () {
                Navigator.pop(context);
                cartBloc.add(
                  CartEventDelete(
                    updateIndex: index,
                  ),
                );
              },
            );
          });

  void _showEmptyCartConfirmationDialog(
    BuildContext viewContext,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Empty Cart',
              content: 'Confirm removing all items from the cart.',
              onConfirm: () {
                Navigator.pop(context);
                viewContext.read<CartBloc>().add(
                      CartEventEmpty(),
                    );
              },
            );
          });
}
