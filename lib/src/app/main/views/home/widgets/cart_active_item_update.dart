import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/string_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_event.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_chain.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

import 'cart_active_item_update_type.dart';
import 'condiment_table_checkbox.dart';
import 'condiment_table_radio.dart';

class CartActiveItemUpdate extends StatefulWidget {
  const CartActiveItemUpdate({
    required this.cartActiveItemUpdateType,
    required this.progressErrorStateType,
    required this.cartActiveItem,
    this.updateIndex,
    Key? key,
  }) : super(key: key);

  final CartActiveItemUpdateType cartActiveItemUpdateType;
  final ProgressErrorStateType progressErrorStateType;
  final CartActiveItem cartActiveItem;
  final int? updateIndex;

  @override
  State<CartActiveItemUpdate> createState() => _CartActiveItemUpdateState();
}

class _CartActiveItemUpdateState extends State<CartActiveItemUpdate> {
  bool _initialised = false;
  late AppFloatingButtonCubit appFloatingButtonCubit;

  List<String?> selectedTexts = List.empty();

  @override
  void didChangeDependencies() {
    final appFloatingButtonCubit =
        BlocProvider.of<AppFloatingButtonCubit>(context);

    if (!_initialised) {
      _initialised = true;
      this.appFloatingButtonCubit = appFloatingButtonCubit;
    } else {
      if (this.appFloatingButtonCubit != appFloatingButtonCubit) {
        this.appFloatingButtonCubit = appFloatingButtonCubit;
      }
    }

    super.didChangeDependencies();
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'qty': [
          widget.cartActiveItem.qty,
          Validators.required,
        ],
        'instructions': [
          if (widget.cartActiveItem.instructions == null)
            ''
          else
            widget.cartActiveItem.instructions,
        ],
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (formContext, form, child) {
          if (widget.progressErrorStateType !=
              ProgressErrorStateType.progressError) {
            switch (widget.cartActiveItemUpdateType) {
              case CartActiveItemUpdateType.addItemView:
                {
                  appFloatingButtonCubit.showFloatingButton(
                    floatingActionButton: _addToCartButton(context, form),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                  );
                  break;
                }

              case CartActiveItemUpdateType.updateItemView:
                {
                  appFloatingButtonCubit.showFloatingButton(
                    floatingActionButton: _continueButton(context, form),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                  );
                  break;
                }
            }
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                              child: const Icon(
                                Icons.indeterminate_check_box_outlined,
                                size: 32,
                              ),
                              onTap: () {
                                if (form.value['qty']! as double > 1) {
                                  setState(
                                    () => form.control('qty').value =
                                        (form.value['qty']! as double) - 1,
                                  );
                                }
                              }),
                          context
                              .watch<MediaSettingsBloc>()
                              .state
                              .formFieldPaddingW,
                          Text(
                            Formats.qty(form.value['qty']! as double),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          context
                              .watch<MediaSettingsBloc>()
                              .state
                              .formFieldPaddingW,
                          InkWell(
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 32,
                            ),
                            onTap: () => setState(
                              () => form.control('qty').value =
                                  (form.value['qty']! as double) + 1,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            context
                                .watch<MediaSettingsBloc>()
                                .state
                                .formFieldPaddingW,
                            Text(
                              Formats.currency(widget.cartActiveItem.price),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            context
                                .watch<MediaSettingsBloc>()
                                .state
                                .formFieldPaddingW,
                            Text(
                              Formats.currency((form.value['qty']! as double) *
                                  widget.cartActiveItem.price),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            context
                                .watch<MediaSettingsBloc>()
                                .state
                                .formFieldPaddingW,
                          ]),
                    ],
                  ),
                ),
                _optionsView(context, form),
                const SizedBox(height: 75.0),
              ],
            ),
          );
        });
  }

  Widget _optionsView(
    BuildContext viewContext,
    FormGroup form,
  ) {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: widget.cartActiveItem.cartActiveChain == null
          ? null
          : widget.cartActiveItem.cartActiveChain!.items[0].sysCondimentTableId,
      children: [
        if (widget.cartActiveItem.cartActiveChain != null)
          ..._chainView(viewContext, widget.cartActiveItem.cartActiveChain!),
        _instructionsView(viewContext),
      ],
    );
  }

  List<ExpansionPanel> _chainView(
    BuildContext viewContext,
    CartActiveChain cartActiveChain,
  ) {
    selectedTexts = List.generate(
      cartActiveChain.items.length,
      (index) => cartActiveChain.items[index].selectedItemsText,
    );

    return List.generate(
        cartActiveChain.items.length,
        (index) => _condimentTableView(
              viewContext,
              cartActiveChain.items[index],
              index,
            ));
  }

  ExpansionPanelRadio _condimentTableView(
    BuildContext viewContext,
    CartCondimentTable cartCondimentTable,
    int index,
  ) {
    return ExpansionPanelRadio(
      canTapOnHeader: true,
      headerBuilder: (viewContext, isOpen) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
                Expanded(
                  child: Text(
                    cartCondimentTable.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  cartCondimentTable.selectText,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            if (selectedTexts[index] != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  viewContext
                      .watch<MediaSettingsBloc>()
                      .state
                      .formFieldPaddingW,
                  Expanded(
                    child: Text(
                      selectedTexts[index]!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .apply(fontStyle: FontStyle.italic),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
      body: _condimentTableItemsView(
        viewContext,
        cartCondimentTable,
        index,
      ),
      value: cartCondimentTable.id,
    );
  }

  Widget _condimentTableItemsView(
    BuildContext viewContext,
    CartCondimentTable cartCondimentTable,
    int index,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.only(top: 0, left: 8.0, right: 8.0, bottom: 8.0),
      child: cartCondimentTable.tQty == 1
          ? CondimentTableRadio(
              cartCondimentTable: cartCondimentTable,
              onSelected: (String? selectedItemsText) =>
                  setState(() => selectedTexts[index] = selectedItemsText),
            )
          : CondimentTableCheckbox(
              cartCondimentTable: cartCondimentTable,
              onSelected: (String? selectedItemsText) =>
                  setState(() => selectedTexts[index] = selectedItemsText),
            ),
    );
  }

  ExpansionPanel _instructionsView(
    BuildContext viewContext,
  ) {
    return ExpansionPanelRadio(
      canTapOnHeader: true,
      headerBuilder: (viewContext, isOpen) {
        return Row(
          children: [
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
            Expanded(
              child: Text(
                'Additional Instructions',
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        );
      },
      body: ReactiveTextField<String>(
        style: Theme.of(context).textTheme.subtitle1,
        readOnly: false,
        minLines: 3,
        maxLines: 5,
        formControlName: 'instructions',
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'for example: no salt',
          labelStyle: Theme.of(context).textTheme.bodyText2,
          helperText: '',
          helperStyle: Theme.of(context).textTheme.bodyText2,
          errorStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      value: 'instructions',
    );
  }

  FloatingActionButton _addToCartButton(
    BuildContext viewContext,
    FormGroup form,
  ) {
    return FloatingActionButton.extended(
      onPressed: () {
        viewContext.read<CartBloc>().add(
              CartEventAdd(
                cartActiveItem: CartActiveItem.userUpdate(
                  qty: form.value['qty']! as double,
                  instructions:
                      (form.value['instructions']! as String).isNullOrEmpty
                          ? null
                          : form.value['instructions']! as String,
                  cartActiveItem: widget.cartActiveItem,
                ),
              ),
            );
      },
      label: const Text('ADD TO CART'),
      icon: const Icon(Icons.add_shopping_cart),
    );
  }

  FloatingActionButton _continueButton(
    BuildContext viewContext,
    FormGroup form,
  ) {
    return FloatingActionButton.extended(
      onPressed: () {
        viewContext.read<CartBloc>().add(
              CartEventUpdate(
                cartActiveItem: CartActiveItem.userUpdate(
                  qty: form.value['qty']! as double,
                  instructions:
                      (form.value['instructions']! as String).isNullOrEmpty
                          ? null
                          : form.value['instructions']! as String,
                  cartActiveItem: widget.cartActiveItem,
                ),
                updateIndex: widget.updateIndex!,
              ),
            );
      },
      label: const Text('UPDATE CART'),
      icon: const Icon(Icons.update),
    );
  }
}
