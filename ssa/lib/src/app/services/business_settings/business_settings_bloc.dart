import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:single_store_app/src/app/models/business/payment_provider.dart';
import 'package:single_store_app/src/app/models/business/payment_provider_type.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_state.dart';

import 'business_settings_event.dart';
import 'business_settings_state.dart';

class BusinessSettingsBloc
    extends Bloc<BusinessSettingsEvent, BusinessSettingsState> {
  BusinessSettingsBloc({
    required BusinessSelectBloc businessSelectBloc,
  }) : super(const BusinessSettingsStatePending()) {
    businessSelectSubscription = businessSelectBloc.stream
        .listen((BusinessSelectState businessSelectState) {
      if (businessSelectState.isSelected) {
        add(BusinessSettingsEventUpdate(
            storeSettings: businessSelectState.selectedStore!));
      }
    });

    on<BusinessSettingsEventUpdate>((event, emit) async {

      final List<PaymentProvider> paymentProviders =
          PaymentProvider.paymentProviderList(
              event.storeSettings.paymentProviders);


      for (final PaymentProvider paymentProvider in paymentProviders) {
        final int index = paymentProviders.indexOf(paymentProvider);

        switch (paymentProvider.paymentProviderType) {
          case PaymentProviderType.none:
            break;

          case PaymentProviderType.stripe:
            {
              if(paymentProvider.available) {
                try {
                  Stripe.publishableKey = paymentProvider.paymentKey;
                  Stripe.merchantIdentifier = null;
                } catch (_) {
                  // Stripe.publishableKey = '';
                  Stripe.merchantIdentifier = null;
                  paymentProviders[index] = PaymentProvider.unavailable(paymentProvider);
                }
              } else {
                // Stripe.publishableKey = '';
                Stripe.merchantIdentifier = null;

              }
            }
            break;
        }
      }

      emit(BusinessSettingsStateLoaded.fromStoreSetting(
        storeSettings: event.storeSettings,
        paymentProviders: paymentProviders,
      ));

    });
  }

  late StreamSubscription businessSelectSubscription;

  @override
  Future<void> close() {
    businessSelectSubscription.cancel();
    return super.close();
  }
}
