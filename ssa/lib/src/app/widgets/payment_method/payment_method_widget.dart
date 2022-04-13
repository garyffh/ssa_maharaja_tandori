import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/payment_method_repo.dart';
import 'package:single_store_app/src/app/models/payment_method/payment_method_controller.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_bloc.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_event.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_state.dart';
import 'package:single_store_app/src/app/widgets/payment_method/stripe_payment_method/stripe_payment_method_widget.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
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
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
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
        return StripePaymentMethodWidget(
          paymentMethodConsumer: widget.paymentMethodConsumer,
          onSubmitted: widget.onSubmitted,
        );

      },
    );
  }
}
