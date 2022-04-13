import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/payment_method_repo.dart';
import 'package:single_store_app/src/app/models/payment_method/payment_method_controller.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_bloc.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_event.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_state.dart';

class StripePaymentMethodWidget extends StatefulWidget {
  const StripePaymentMethodWidget({
    required this.paymentMethodConsumer,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  final Widget Function(
    BuildContext paymentMethodWidgetContext,
    FormGroup paymentAddForm,
    PaymentMethodWidgetState paymentMethodWidgetState,
    PaymentMethodController paymentMethodController,
  ) paymentMethodConsumer;
  final void Function()? onSubmitted;

  @override
  State<StripePaymentMethodWidget> createState() =>
      _StripePaymentMethodWidgetState();
}

class _StripePaymentMethodWidgetState extends State<StripePaymentMethodWidget> {
  bool _initialised = false;
  late bool isMobilePlatform;

  @override
  void didChangeDependencies() {
    final isMobilePlatform =
        context.watch<MediaSettingsBloc>().state.isMobilePlatform;

    if (!_initialised) {
      _initialised = true;
      this.isMobilePlatform = isMobilePlatform;
    } else {
      if (this.isMobilePlatform != isMobilePlatform) {
        this.isMobilePlatform = isMobilePlatform;
      }
    }

    super.didChangeDependencies();
  }

  PaymentMethodController _paymentMethodController = PaymentMethodController(
    complete: false,
    onClear: null,
  );

  FormGroup buildForm() => fb.group(<String, Object>{
        'cardName': [
          '',
          Validators.required,
        ],
      });

  // CardFieldInputDetails? _card;
  CardEditController? _cardEditController;

  CardEditController? get cardEditController {
    if (isMobilePlatform) {
      _cardEditController ??= CardEditController();
      return _cardEditController;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentMethodWidgetBloc(
        paymentMethodRepo: context.read<PaymentMethodRepo>(),
        businessSettingsBloc: context.read<BusinessSettingsBloc>(),
      ),
      child: _viewModel(context),
    );
  }

  Widget _viewModel(BuildContext context) {
    if (isMobilePlatform) {
      return _viewForm();
    } else {
      return Center(
        child: Text(
          'Available on mobile platform!',
          style: context.watch<MediaSettingsBloc>().state.headline6,
        ),
      );
    }
  }

  Widget _viewForm() {
    return BlocConsumer<PaymentMethodWidgetBloc, PaymentMethodWidgetState>(
      listener: (paymentMethodWidgetContext, state) {
        if (state.type == ProgressErrorStateType.submitted) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!();
          }
          paymentMethodWidgetContext.read<PaymentMethodWidgetBloc>().add(
                PaymentMethodWidgetEventResetError(),
              );
        }
      },
      builder: (viewContext, viewState) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: viewContext.watch<MediaSettingsBloc>().state.formMaxWidth,
          ),
          padding: EdgeInsets.symmetric(
            horizontal:
                viewContext.watch<MediaSettingsBloc>().state.formPadding,
          ),
          child: ReactiveFormBuilder(
            form: buildForm,
            builder: (formContext, form, child) {
              return Column(
                children: [
                  viewContext.watch<MediaSettingsBloc>().state.padding,
                  ReactiveTextField<String>(
                    autofocus: true,
                    style: viewContext
                        .watch<MediaSettingsBloc>()
                        .state
                        .formFieldTextStyle,
                    readOnly: viewState.formIsReadOnly,
                    formControlName: 'cardName',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Name on card is required',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Name on card',
                      helperText: '',
                      helperStyle: viewContext
                          .watch<MediaSettingsBloc>()
                          .state
                          .formHelperTextStyle,
                      errorStyle: viewContext
                          .watch<MediaSettingsBloc>()
                          .state
                          .formErrorTextStyle,
                    ),
                  ),
                  viewContext
                      .watch<MediaSettingsBloc>()
                      .state
                      .formFieldPaddingH,
                  CardField(
                    controller: cardEditController,
                    onCardChanged: (card) {
                      setState(() {
                        // _card = card;
                        if (card == null) {
                          _paymentMethodController = PaymentMethodController(
                            complete: false,
                            onClear: () => cardEditController!.clear(),
                          );
                        } else {
                          _paymentMethodController = PaymentMethodController(
                            complete: card.complete,
                            onClear: () => cardEditController!.clear(),
                          );
                        }
                      });
                    },
                  ),
                  viewContext
                      .watch<MediaSettingsBloc>()
                      .state
                      .formFieldPaddingH,
                  ReactiveFormConsumer(
                    builder: (formContext, form, child) =>
                        widget.paymentMethodConsumer(
                      viewContext,
                      form,
                      viewState,
                      _paymentMethodController,
                    ),
                  ),
                  viewContext
                      .watch<MediaSettingsBloc>()
                      .state
                      .formFieldPaddingH,
                  FormErrorMessageWidget(
                    errorMessage: viewState.stateErrorMessage(),
                  ),
                  viewContext.watch<MediaSettingsBloc>().state.padding,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
