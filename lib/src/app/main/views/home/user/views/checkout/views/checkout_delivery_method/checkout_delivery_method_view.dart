import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/app_validators.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/date_time_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_state.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/checkout_message_widget.dart';
import 'package:single_store_app/src/app/models/checkout/checkout_delivery_method_interval.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_delivery_method.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

import 'checkout_delivery_method_bloc.dart';
import 'checkout_delivery_method_event.dart';
import 'checkout_delivery_method_state.dart';
import 'models/delivery_method_control_state.dart';
import 'models/delivery_method_control_states.dart';

class CheckoutDeliveryMethodView extends StatefulWidget {
  const CheckoutDeliveryMethodView({
    required this.trnCheckoutDeliveryMethod,
    Key? key,
  }) : super(key: key);

  final TrnCheckoutDeliveryMethod? trnCheckoutDeliveryMethod;

  @override
  State<StatefulWidget> createState() => _CheckoutDeliveryMethodViewState();
}

class _CheckoutDeliveryMethodViewState
    extends State<CheckoutDeliveryMethodView> {
  late FormGroup form;
  List<bool> isSelected = List.empty(growable: true);

  @override
  void initState() {
    form = FormGroup({
      'selectedType': FormControl<DeliveryMethodType>(
        value: widget.trnCheckoutDeliveryMethod == null
            ? null
            : widget.trnCheckoutDeliveryMethod!.deliveryMethodType,
        validators: [Validators.required],
      ),
      'noSelectedTypeError': FormControl<bool>(
        value: true,
        validators: [Validators.requiredTrue],
      ),
      'storeTime': FormControl<CheckoutDeliveryMethodInterval>(
        value: widget.trnCheckoutDeliveryMethod == null
            ? null
            : widget.trnCheckoutDeliveryMethod!.storeDeliveryMethodInterval,
      ),
      'deliveryTime': FormControl<CheckoutDeliveryMethodInterval>(
        value: widget.trnCheckoutDeliveryMethod == null
            ? null
            : widget.trnCheckoutDeliveryMethod!.deliveryDeliveryMethodInterval,
      ),
      'periodTime': FormControl<CheckoutDeliveryMethodInterval>(
        value: widget.trnCheckoutDeliveryMethod == null
            ? null
            : widget.trnCheckoutDeliveryMethod!.periodDeliveryMethodInterval,
      ),
      'tableNumber': FormControl<String>(
        value: widget.trnCheckoutDeliveryMethod == null
            ? null
            : widget.trnCheckoutDeliveryMethod!.tableNumber,
      ),
    }, validators: [
      AppValidators.deliveryMethod(
        'selectedType',
      ),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutDeliveryMethodBloc(
        homeNavCubit: context.read<HomeNavCubit>(),
        storeStatusBloc: context.read<StoreStatusBloc>(),
        appNavigatorCubit: context.read<AppNavigatorCubit>(),
        checkoutNavCubit: context.read<CheckoutNavCubit>(),
        checkoutBloc: context.read<CheckoutBloc>(),
        checkoutStepperBloc: context.read<CheckoutStepperBloc>(),
      )..add(CheckoutDeliveryMethodEventGetViewModel()),
      child:
          BlocBuilder<CheckoutDeliveryMethodBloc, CheckoutDeliveryMethodState>(
        builder: (viewContext, state) {
          return _view(viewContext, state);
        },
      ),
    );
  }

  Widget _view(
      BuildContext viewContext, CheckoutDeliveryMethodState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          try {
            if (viewContext.read<CartBloc>().state is! CartStateViewModel) {
              throw Exception('Unhandled state');
            }

            if (viewContext.read<BusinessSettingsBloc>().state
                is! BusinessSettingsStateLoaded) {
              throw Exception('Unhandled state');
            }

            return _viewModel(
              viewContext,
              viewState as CheckoutDeliveryMethodStateViewModel,
              viewContext.read<CartBloc>().state as CartStateViewModel,
              viewContext.read<BusinessSettingsBloc>().state
                  as BusinessSettingsStateLoaded,
            );
          } catch (e) {
            return const UnhandledStateWidget();
          }
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CheckoutDeliveryMethodBloc>()
                .add(CheckoutDeliveryMethodEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () => viewContext
                .read<CheckoutDeliveryMethodBloc>()
                .add(CheckoutDeliveryMethodEventGetViewModel()),
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
    CheckoutDeliveryMethodStateViewModel viewModel,
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
  ) {
    final DeliveryMethodControlStates deliveryMethodControlStates =
        DeliveryMethodControlStates.fromDeliveryMethodTypes(
      viewModel.checkoutDeliveryMethod
          .activeDeliveryMethods(businessSettingsStateLoaded.tableService),
    );

    _updateIsSelected(deliveryMethodControlStates.activeDeliveryMethodStates);

    return ReactiveForm(
      formGroup: form,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _methodToggleButtons(
              viewContext,
              viewModel,
              cartStateViewModel,
              businessSettingsStateLoaded,
              deliveryMethodControlStates,
              form,
            ),
            _methodContent(
              viewContext,
              cartStateViewModel,
              businessSettingsStateLoaded,
              deliveryMethodControlStates,
            ),
            if (form.control('noSelectedTypeError').value as bool)
              _methodForm(
                viewContext,
                viewModel,
                cartStateViewModel,
                businessSettingsStateLoaded,
                deliveryMethodControlStates,
              ),
            ReactiveFormConsumer(
              builder: (formContext, form, child) {
                viewContext.read<AppFloatingButtonCubit>().showFloatingButtons(
                  buttons: [
                    _continueButton(
                      viewContext,
                      viewModel,
                      deliveryMethodControlStates,
                      form,
                    )
                  ],
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                );

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _methodToggleButtons(
    BuildContext viewContext,
    CheckoutDeliveryMethodStateViewModel viewModel,
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
    DeliveryMethodControlStates deliveryMethodControlStates,
    FormGroup form,
  ) {
    return ToggleButtons(
      children: List<Widget>.generate(
          deliveryMethodControlStates.activeDeliveryMethodStates.length,
          (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              if (isSelected[index]) const Icon(Icons.check),
              Text(
                deliveryMethodControlStates
                    .activeDeliveryMethodStates[index].deliveryMethodType.text,
                style: Theme.of(viewContext).textTheme.caption,
              ),
            ],
          ),
        );
      }),
      isSelected: isSelected,
      onPressed: (int index) {
        final DeliveryMethodType selectedType = deliveryMethodControlStates
            .activeDeliveryMethodStates[index].deliveryMethodType;

        form.control('selectedType').value = selectedType;

        form.control('noSelectedTypeError').value = _hasNoSelectedTypeError(
          cartStateViewModel,
          businessSettingsStateLoaded,
          selectedType,
        );

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

  bool _hasNoSelectedTypeError(
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
    DeliveryMethodType deliveryMethodType,
  ) {
    switch (deliveryMethodType) {
      case DeliveryMethodType.store:
        return true;
      case DeliveryMethodType.delivery:
        {
          if (minOrderError(cartStateViewModel, businessSettingsStateLoaded)) {
            return false;
          } else {
            return true;
          }
        }
      case DeliveryMethodType.table:
        return true;
      case DeliveryMethodType.period:
        {
          if (minOrderError(cartStateViewModel, businessSettingsStateLoaded)) {
            return false;
          } else {
            return true;
          }
        }
    }
  }

  Widget _methodContent(
    BuildContext viewContext,
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
    DeliveryMethodControlStates deliveryMethodControlStates,
  ) {
    final int selectedIndex = isSelected.indexWhere((element) => element);
    if (selectedIndex >= 0) {
      final DeliveryMethodType selectedDeliveryMethodType =
          deliveryMethodControlStates
              .activeDeliveryMethodStates[selectedIndex].deliveryMethodType;

      switch (selectedDeliveryMethodType) {
        case DeliveryMethodType.store:
          return _storeMethodContent(viewContext);

        case DeliveryMethodType.delivery:
          return _deliveryMethodContent(
            viewContext,
            cartStateViewModel,
            businessSettingsStateLoaded,
          );
        case DeliveryMethodType.table:
          return _tableMethodContent(viewContext);
        case DeliveryMethodType.period:
          return _deliveryMethodContent(
            viewContext,
            cartStateViewModel,
            businessSettingsStateLoaded,
          );

      }
    } else {
      return _unselectedMethodContent(viewContext);
    }
  }

  Widget _methodForm(
    BuildContext viewContext,
    CheckoutDeliveryMethodStateViewModel viewModel,
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
    DeliveryMethodControlStates deliveryMethodControlStates,
  ) {
    final int selectedIndex = isSelected.indexWhere((element) => element);
    if (selectedIndex >= 0) {
      final DeliveryMethodType selectedDeliveryMethodType =
          deliveryMethodControlStates
              .activeDeliveryMethodStates[selectedIndex].deliveryMethodType;

      switch (selectedDeliveryMethodType) {
        case DeliveryMethodType.store:
          return Container(
            constraints: BoxConstraints(
              maxWidth: viewContext.watch<MediaSettingsBloc>().state.sp(55),
            ),
            child: ReactiveDropdownField<CheckoutDeliveryMethodInterval>(
              key: const ValueKey('storeTime'),
              style: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formFieldTextStyle,
              formControlName: 'storeTime',
              hint: Text(
                'Pick-up time',
                style: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
              ),
              validationMessages: (control) => {
                ValidationMessage.required: 'Time is required',
              },
              items: List.generate(
                viewModel.checkoutDeliveryMethod.storeTimes.length,
                (index) => DropdownMenuItem<CheckoutDeliveryMethodInterval>(
                  value: viewModel.checkoutDeliveryMethod.storeTimes[index],
                  child: Text(
                    viewModel.checkoutDeliveryMethod.storeTimes[index].display,
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                ),
              ),
            ),
          );

        case DeliveryMethodType.delivery:
          return Container(
            constraints: BoxConstraints(
                maxWidth: viewContext.watch<MediaSettingsBloc>().state.sp(55)),
            child: ReactiveDropdownField<CheckoutDeliveryMethodInterval>(
              key: const ValueKey('deliveryTime'),
              style: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formFieldTextStyle,
              formControlName: 'deliveryTime',
              hint: Text(
                'Delivery time',
                style: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
              ),
              validationMessages: (control) => {
                ValidationMessage.required: 'Time is required',
              },
              items: List.generate(
                viewModel.checkoutDeliveryMethod.deliveryTimes.length,
                (index) => DropdownMenuItem<CheckoutDeliveryMethodInterval>(
                  value: viewModel.checkoutDeliveryMethod.deliveryTimes[index],
                  child: Text(
                    viewModel
                        .checkoutDeliveryMethod.deliveryTimes[index].display,
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                ),
              ),
            ),
          );

        case DeliveryMethodType.table:
          return Container(
            constraints: BoxConstraints(
              maxWidth: viewContext.watch<MediaSettingsBloc>().state.sp(55),
            ),
            child: ReactiveTextField<String>(
              key: const ValueKey('tableNumber'),
              keyboardType: TextInputType.number,
              style: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formFieldTextStyle,
              formControlName: 'tableNumber',
              validationMessages: (control) => {
                ValidationMessage.required: 'Table # required',
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Table number',
                labelStyle: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
                helperText: '',
                helperStyle: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
                errorStyle:
                    context.watch<MediaSettingsBloc>().state.formErrorTextStyle,
              ),
            ),
          );

        case DeliveryMethodType.period:
          return Container(
            constraints: BoxConstraints(
              maxWidth: viewContext.watch<MediaSettingsBloc>().state.sp(68),
            ),
            child: ReactiveDropdownField<CheckoutDeliveryMethodInterval>(
              key: const ValueKey('periodTime'),
              style: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formFieldTextStyle,
              formControlName: 'periodTime',
              hint: Text(
                'Delivery time',
                style: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
              ),
              validationMessages: (control) => {
                ValidationMessage.required: 'Time is required',
              },
              items: List.generate(
                viewModel.checkoutDeliveryMethod.periodTimes.length,
                (index) => DropdownMenuItem<CheckoutDeliveryMethodInterval>(
                  value: viewModel.checkoutDeliveryMethod.periodTimes[index],
                  child: Text(
                    viewModel.checkoutDeliveryMethod.periodTimes[index].display,
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                ),
              ),
            ),
          );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _unselectedMethodContent(BuildContext viewContext) {
    return const CheckoutMessageWidget(
        message: ['Please select how to', 'receive your order.'], error: false);
  }

  Widget _storeMethodContent(BuildContext viewContext) {
    return const CheckoutMessageWidget(
        message: ['Select your pick-up time.'], error: false);
  }

  Widget _deliveryMethodContent(
    BuildContext viewContext,
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
  ) {
    if (minOrderError(cartStateViewModel, businessSettingsStateLoaded)) {
      return CheckoutMessageWidget(message: [
        'Minimum delivery ${Formats.currency(businessSettingsStateLoaded.minOrder)}.',
        'Add ${Formats.currency(businessSettingsStateLoaded.minOrder - cartStateViewModel.cart.cartTotals.total)} to your order.',
      ], error: true);
    } else {
      return const CheckoutMessageWidget(
          message: ['Select your delivery time.'], error: false);
    }
  }

  Widget _tableMethodContent(BuildContext viewContext) {
    return const CheckoutMessageWidget(
        message: ['Enter your table number.'], error: false);
  }


  bool minOrderError(
    CartStateViewModel cartStateViewModel,
    BusinessSettingsStateLoaded businessSettingsStateLoaded,
  ) {
    if (businessSettingsStateLoaded.minOrder == 0) {
      return false;
    } else {
      return cartStateViewModel.cart.cartTotals.total <
          businessSettingsStateLoaded.minOrder;
    }
  }

  void _updateIsSelected(
    List<DeliveryMethodControlState> activeDeliveryMethods,
  ) {
    if (isSelected.length != activeDeliveryMethods.length) {
      isSelected.clear();
      if (activeDeliveryMethods.length == 1) {
        isSelected.add(true);
        form.control('selectedType').value =
            activeDeliveryMethods[0].deliveryMethodType;
      } else {
        for (int count = 1; count <= activeDeliveryMethods.length; count++) {
          if (form.control('selectedType').value == null) {
            isSelected.add(false);
          } else {
            if (form.control('selectedType').value ==
                activeDeliveryMethods[count - 1].deliveryMethodType) {
              isSelected.add(true);
            } else {
              isSelected.add(false);
            }
          }
        }
      }
    }
  }

  Widget _continueButton(
    BuildContext viewContext,
    CheckoutDeliveryMethodStateViewModel viewModel,
    DeliveryMethodControlStates deliveryMethodControlStates,
    FormGroup form,
  ) {
    return ElevatedActionButton(
      text: 'CONTINUE',
      iconData: Icons.arrow_right,
      onPressed: form.valid
          ? () => viewContext.read<CheckoutDeliveryMethodBloc>().add(
                CheckoutDeliveryMethodEventSubmit(
                  trnCheckoutDeliveryMethod: TrnCheckoutDeliveryMethod(
                    storeStatusTime: viewModel
                        .checkoutDeliveryMethod.storeStatusTime
                        .copyWith(),
                    deliveryMethodType: form.control('selectedType').value
                        as DeliveryMethodType,
                    storeDeliveryMethodInterval: form.control('storeTime').value
                        as CheckoutDeliveryMethodInterval?,
                    deliveryDeliveryMethodInterval: form
                        .control('deliveryTime')
                        .value as CheckoutDeliveryMethodInterval?,
                    periodDeliveryMethodInterval: form
                        .control('periodTime')
                        .value as CheckoutDeliveryMethodInterval?,
                    tableNumber: form.control('tableNumber').value as String?,
                  ),
                ),
              )
          : null,
    );
  }
}
