import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/checkout_repo.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_state.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/payment_option_type.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/checkout_address_widget.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/checkout_message_widget.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_chain.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table_item.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/column_builder.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';
import 'package:single_store_app/src/app/widgets/ui/line_description_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_qty_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_total_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_unit_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_line.dart';

import 'checkout_submit_bloc.dart';
import 'checkout_submit_event.dart';
import 'checkout_submit_state.dart';
import 'models/checkout_submit_method.dart';
import 'models/payment_option_control_state.dart';
import 'models/payment_option_control_states.dart';

class CheckoutSubmitView extends StatefulWidget {
  const CheckoutSubmitView({Key? key}) : super(key: key);

  @override
  State<CheckoutSubmitView> createState() => _CheckoutSubmitStateView();
}

class _CheckoutSubmitStateView extends State<CheckoutSubmitView> {
  late FormGroup form;
  List<bool> isSelected = List.empty(growable: true);

  @override
  void initState() {
    form = FormGroup(
      {
        'selectedType': FormControl<PaymentOptionType>(
          value: null,
          validators: [Validators.required],
        ),
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutSubmitBloc(
        checkoutNavCubit: context.read<CheckoutNavCubit>(),
        checkoutBloc: context.read<CheckoutBloc>(),
        cartBloc: context.read<CartBloc>(),
        userBusinessBloc: context.read<UserBusinessBloc>(),
        storeStatusBloc: context.read<StoreStatusBloc>(),
        businessSettingsBloc: context.read<BusinessSettingsBloc>(),
        checkoutRepo: context.read<CheckoutRepo>(),
      )..add(CheckoutSubmitEventGetViewModel()),
      child: BlocBuilder<CheckoutSubmitBloc, CheckoutSubmitState>(
          builder: (viewContext, state) {
        return _view(viewContext, state);
      }),
    );
  }

  Widget _view(BuildContext viewContext, CheckoutSubmitState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
      case ProgressErrorStateType.submitted:
        {
          return _viewModel(
            viewContext,
            viewState as CheckoutSubmitStateViewModel,
          );
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CheckoutSubmitBloc>()
                .add(CheckoutSubmitEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () => viewContext
                .read<CheckoutSubmitBloc>()
                .add(CheckoutSubmitEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.idle:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    CheckoutSubmitStateViewModel viewModel,
  ) {
    final PaymentOptionControlStates paymentOptionControlStates =
        PaymentOptionControlStates.fromTrnCheckoutSubmit(
      viewModel.trnCheckoutSubmit,
    );

    _updateIsSelected(paymentOptionControlStates.activePaymentOptionStates);

    return ReactiveForm(
      formGroup: form,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _paymentOptionToggleButtons(
              viewContext,
              viewModel,
              paymentOptionControlStates,
              form,
            ),
            _paymentSummaryWidget(
              viewContext,
              viewModel,
              paymentOptionControlStates,
              form,
            ),
            _deliveryMethodWidget(viewContext),
            _addressWidget(viewContext),
            _phoneWidget(viewContext),
            _cartWidget(viewContext),
            const SizedBox(height: 40.0),
            ReactiveFormConsumer(
              builder: (formContext, form, child) {
                if (viewModel.type == ProgressErrorStateType.loaded) {
                  viewContext
                      .read<AppFloatingButtonCubit>()
                      .showFloatingButtons(
                    buttons: [
                      _backButton(viewContext),
                      _submitButton(
                        viewContext,
                        form,
                      )
                    ],
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOptionToggleButtons(
    BuildContext viewContext,
    CheckoutSubmitStateViewModel viewModel,
    PaymentOptionControlStates paymentOptionControlStates,
    FormGroup form,
  ) {
    return ToggleButtons(
      children: List<Widget>.generate(
          paymentOptionControlStates.activePaymentOptionStates.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              if (isSelected[index]) const Icon(Icons.check),
              Container(
                constraints: const BoxConstraints(minWidth: 75.0),
                child: Text(
                  paymentOptionControlStates
                      .activePaymentOptionStates[index].paymentOptionType.text,
                  style: Theme.of(viewContext).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      }),
      isSelected: isSelected,
      onPressed: (int index) {
        final PaymentOptionType selectedType = paymentOptionControlStates
            .activePaymentOptionStates[index].paymentOptionType;

        form.control('selectedType').value = selectedType;

        for (int buttonIndex = 0;
            buttonIndex < isSelected.length;
            buttonIndex++) {
          if (buttonIndex == index) {
            isSelected[buttonIndex] = true;
          } else {
            isSelected[buttonIndex] = false;
          }
        }

        setState(() {});
      },
    );
  }

  Widget _paymentSummaryWidget(
    BuildContext viewContext,
    CheckoutSubmitStateViewModel viewModel,
    PaymentOptionControlStates paymentOptionControlStates,
    FormGroup form,
  ) {
    final PaymentOptionType? paymentOptionType =
        form.control('selectedType').value as PaymentOptionType?;
    if (paymentOptionType == null) {
      return const CheckoutMessageWidget(
          message: ['Select a payment option.'], error: false);
    } else {
      return Card(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: context.watch<MediaSettingsBloc>().state.formPadding,
            horizontal: context.watch<MediaSettingsBloc>().state.formPadding,
          ),
          child: Column(
            children: [
              NameValueLine(
                name: viewModel.trnCheckoutSubmit.cartTotalLabel,
                value: viewModel.trnCheckoutSubmit.cartTotal,
                showLine: true,
              ),
              if (viewModel.trnCheckoutSubmit.hasPromotion)
                NameValueLine(
                  name: viewModel.trnCheckoutSubmit.promotionLabel,
                  value: viewModel.trnCheckoutSubmit.promotionAmount,
                  isCurrency: true,
                ),
              if (viewModel.trnCheckoutSubmit.hasPromotion)
                NameValueLine(
                  name: viewModel.trnCheckoutSubmit.promotionSubtotalLabel,
                  value: viewModel.trnCheckoutSubmit.promotionSubtotal,
                  showLine: true,
                ),
              if (viewModel.trnCheckoutSubmit.hasDeliveryFee)
                NameValueLine(
                  name: viewModel.trnCheckoutSubmit.deliveryFeeLabel,
                  value: viewModel.trnCheckoutSubmit.deliveryFeeAmount,
                ),
              if (viewModel.trnCheckoutSubmit.hasDeliveryPromotion)
                NameValueLine(
                  name:
                      viewModel.trnCheckoutSubmit.deliveryPromotionAmountLabel,
                  value: viewModel.trnCheckoutSubmit.deliveryPromotionAmount,
                ),
              if (viewModel.trnCheckoutSubmit.hasDeliveryFee ||
                  viewModel.trnCheckoutSubmit.hasDeliveryPromotion)
                NameValueLine(
                  name: viewModel.trnCheckoutSubmit.orderTotalLabel,
                  value: viewModel.trnCheckoutSubmit.orderTotal,
                  showLine: true,
                ),
              if (paymentOptionType == PaymentOptionType.redeem)
                NameValueLine(
                  name: viewModel.trnCheckoutSubmit.orderRedeemCurrencyLabel,
                  value: viewModel.trnCheckoutSubmit.orderRedeemCurrency,
                  highlight: true,
                ),
              if (paymentOptionType == PaymentOptionType.redeem &&
                  viewModel.trnCheckoutSubmit.hasRedeemPayment)
                NameValueLine(
                  name:
                      '${viewModel.trnCheckoutSubmit.paymentTotalLabel} (${PaymentOptionType.paymentMethod.text})',
                  value: viewModel.trnCheckoutSubmit.redeemPaymentTotal,
                  highlight: true,
                ),
              if (paymentOptionType != PaymentOptionType.redeem)
                NameValueLine(
                  name: paymentOptionType == PaymentOptionType.paymentMethod
                      ? '${viewModel.trnCheckoutSubmit.paymentTotalLabel} (${PaymentOptionType.paymentMethod.text})'
                      : viewModel.trnCheckoutSubmit.paymentTotalLabel,
                  value: viewModel.trnCheckoutSubmit.orderTotal,
                  highlight: true,
                ),
            ],
          ),
        ),
      );
    }
  }

  Widget _deliveryMethodWidget(
    BuildContext viewContext,
  ) {
    if (viewContext
            .read<CheckoutBloc>()
            .state
            .trnCheckout
            .trnCheckoutDeliveryMethod ==
        null) {
      return const SizedBox.shrink();
    } else {
      return ActionCardWidget(
        title: viewContext
            .read<CheckoutBloc>()
            .state
            .trnCheckout
            .trnCheckoutDeliveryMethod!
            .title,
        content: Text(
          viewContext
              .read<CheckoutBloc>()
              .state
              .trnCheckout
              .trnCheckoutDeliveryMethod!
              .content,
          style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget _addressWidget(
    BuildContext viewContext,
  ) {
    if (viewContext.read<CheckoutBloc>().state.trnCheckout.trnCheckoutAddress ==
            null ||
        viewContext
                .read<CheckoutBloc>()
                .state
                .trnCheckout
                .trnCheckoutDeliveryMethod ==
            null) {
      return const SizedBox.shrink();
    } else {
      return ActionCardWidget(
        title: viewContext
            .read<CheckoutBloc>()
            .state
            .trnCheckout
            .trnCheckoutDeliveryMethod!
            .deliveryMethodType
            .checkoutAddressText,
        content: CheckoutAddressWidget(
          trnCheckoutAddress: viewContext
              .read<CheckoutBloc>()
              .state
              .trnCheckout
              .trnCheckoutAddress,
          showCountry: false,
        ),
      );
    }
  }

  Widget _phoneWidget(
    BuildContext viewContext,
  ) {
    if (viewContext.read<CheckoutBloc>().state.trnCheckout.trnCheckoutPhone ==
        null) {
      return const SizedBox.shrink();
    } else {
      return ActionCardWidget(
        title: 'Mobile',
        content: Text(
          viewContext
              .read<CheckoutBloc>()
              .state
              .trnCheckout
              .trnCheckoutPhone!
              .phoneNumber,
          style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget _cartWidget(BuildContext viewContext) {
    if (viewContext.read<CartBloc>().state is CartStateViewModel) {
      return ActionCardWidget(
        title: 'Order Items',
        content: _cartLinesWidget(
          viewContext,
          viewContext.read<CartBloc>().state as CartStateViewModel,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _cartLinesWidget(
    BuildContext viewContext,
    CartStateViewModel cartStateViewModel,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth:
                    viewContext.read<MediaSettingsBloc>().state.lgWidthSize),
            child: ColumnBuilder(
              itemCount: cartStateViewModel.cart.cartActive.items.length,
              itemBuilder: (BuildContext context, int index) {
                return _cartItemWidget(
                  viewContext,
                  cartStateViewModel.cart.cartActive.items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartItemWidget(
    BuildContext viewContext,
    CartActiveItem item,
  ) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      width: double.infinity,
      child: Table(
        columnWidths: <int, TableColumnWidth>{
          0: FixedColumnWidth(context.watch<MediaSettingsBloc>().state.sp30),
          1: const FlexColumnWidth(),
          2: const IntrinsicColumnWidth(),
          3: const IntrinsicColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: [
          TableRow(
            children: <Widget>[
              LineQtyCell(
                show: true,
                isScale: item.scale,
                qty: item.qty,
              ),
              LineDescriptionCell(
                isCondiment: false,
                isInstructions: false,
                description: item.name,
              ),
              LineUnitCell(
                isCondiment: false,
                unit: item.price,
              ),
              LineTotalCell(
                isCondiment: false,
                total: item.total,
              ),
            ],
          ),
          if (item.cartActiveChain != null)
            ..._cartItemCondimentsWidget(viewContext, item.cartActiveChain!),
          if (item.instructions != null)
            _cartItemInstructionsWidget(viewContext, item.instructions!),
        ],
      ),
    );
  }

  List<TableRow> _cartItemCondimentsWidget(
    BuildContext viewContext,
    CartActiveChain cartActiveChain,
  ) {
    final List<CartCondimentTableItem> selectedItems =
        cartActiveChain.selectedItems;

    return List<TableRow>.generate(selectedItems.length, (index) {
      final CartCondimentTableItem item = selectedItems[index];
      return TableRow(
        children: <Widget>[
          LineQtyCell(
            show: false,
            isScale: false,
            qty: item.qty,
          ),
          LineDescriptionCell(
            isCondiment: true,
            isInstructions: false,
            description: item.name,
          ),
          LineUnitCell(
            isCondiment: true,
            unit: item.price,
          ),
          LineTotalCell(
            isCondiment: true,
            total: item.total,
          ),
        ],
      );
    });
  }

  TableRow _cartItemInstructionsWidget(
    BuildContext viewContext,
    String instructions,
  ) {
    return TableRow(
      children: <Widget>[
        const LineQtyCell(
          show: false,
          isScale: false,
          qty: 1,
        ),
        LineDescriptionCell(
          isCondiment: false,
          isInstructions: true,
          description: instructions,
        ),
        const LineUnitCell(
          isCondiment: true,
          unit: 0,
        ),
        const LineTotalCell(
          isCondiment: true,
          total: 0,
        ),
      ],
    );
  }

  void _updateIsSelected(
    List<PaymentOptionControlState> activePaymentOptions,
  ) {
    if (isSelected.length != activePaymentOptions.length) {
      isSelected.clear();
      if (activePaymentOptions.length == 1) {
        isSelected.add(true);
        form.control('selectedType').value =
            activePaymentOptions[0].paymentOptionType;
      } else {
        bool hasSelectedItem = false;
        for (int count = 1; count <= activePaymentOptions.length; count++) {
          if (form.control('selectedType').value == null) {
            isSelected.add(false);
          } else {
            if (form.control('selectedType').value ==
                activePaymentOptions[count - 1].paymentOptionType) {
              isSelected.add(true);
              hasSelectedItem = true;
            } else {
              isSelected.add(false);
            }
          }

          if (!hasSelectedItem && activePaymentOptions.isNotEmpty) {
            isSelected[0] = true;
            form.control('selectedType').value =
                activePaymentOptions[0].paymentOptionType;
          }
        }
      }
    }
  }

  Widget _submitButton(
    BuildContext viewContext,
    FormGroup form,
  ) {
    return Container(

      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'SUBMIT',
        iconData: Icons.arrow_right,
        onPressed: form.valid
            ? () => viewContext
                .read<CheckoutSubmitBloc>()
                .add(CheckoutSubmitEventSubmit(
                  checkoutSubmitMethod: CheckoutSubmitMethod(
                    paymentOptionType: form.control('selectedType').value as PaymentOptionType,
                  ),
                ))
            : null,
      ),
    );
  }

  Widget _backButton(BuildContext viewContext) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: ElevatedActionButton(
        text: 'BACK',
        iconData: Icons.arrow_left,
        onPressed: () => viewContext
            .read<CheckoutStepperBloc>()
            .add(CheckoutStepperEventBack()),
      ),
    );
  }
}
