import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_address/models/checkout_address_view_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

import 'checkout_address_event.dart';
import 'checkout_address_state.dart';

class CheckoutAddressBloc
    extends Bloc<CheckoutAddressEvent, CheckoutAddressState> {
  CheckoutAddressBloc({
    required this.checkoutNavCubit,
    required this.checkoutBloc,
    required this.checkoutStepperBloc,
    required this.businessSettingsBloc,
  }) : super(const CheckoutAddressStateInitial()) {
    on<CheckoutAddressEventGetViewModel>((event, emit) async {
      try {
        emit(CheckoutAddressStateLoadingError.fromState(
            checkoutAddressState: state));

        if (businessSettingsBloc.state.type !=
            BusinessSettingStateType.loaded) {
          throw CheckoutAddressStateLoadingError.fromUnexpectedState(
            checkoutAddressState: state,
          );
        }

        final BusinessSettingsStateLoaded businessSettingsStateLoaded =
            businessSettingsBloc.state as BusinessSettingsStateLoaded;

        emit(CheckoutAddressStateLoaded.fromTrnCheckout(
          trnCheckout: checkoutBloc.state.trnCheckout,
          maxDeliveryDistance: businessSettingsStateLoaded.maxDeliveryDistance,
        ));
      } on CheckoutAddressStateLoadingError catch (e) {
        emit(e);
      } catch (e) {
        emit(CheckoutAddressStateLoadingError.fromState(
            checkoutAddressState: state, error: e));
      }
    });

    on<CheckoutAddressEventShowUpdate>((event, emit) async {
      if (state is CheckoutAddressStateViewModel) {
        final CheckoutAddressStateViewModel stateViewModel =
            state as CheckoutAddressStateViewModel;
        try {
          emit(CheckoutAddressStateLoaded(
            checkoutAddressViewType: CheckoutAddressViewType.update,
            trnCheckoutAddress: stateViewModel.trnCheckoutAddress,
            validAddressDistance: stateViewModel.validAddressDistance,
          ));
        } catch (e) {
          emit(CheckoutAddressStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutAddressStateLoadingError.fromState(
          checkoutAddressState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutAddressEventShowView>((event, emit) async {
      if (state is CheckoutAddressStateViewModel) {
        final CheckoutAddressStateViewModel stateViewModel =
            state as CheckoutAddressStateViewModel;
        try {
          emit(CheckoutAddressStateLoaded(
            checkoutAddressViewType: CheckoutAddressViewType.view,
            trnCheckoutAddress: stateViewModel.trnCheckoutAddress,
            validAddressDistance: stateViewModel.validAddressDistance,
          ));
        } catch (e) {
          emit(CheckoutAddressStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutAddressStateLoadingError.fromState(
          checkoutAddressState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutAddressEventUpdate>((event, emit) async {
      if (state is CheckoutAddressStateViewModel) {
        final CheckoutAddressStateViewModel stateViewModel =
            state as CheckoutAddressStateViewModel;

        try {
          if (businessSettingsBloc.state.type !=
              BusinessSettingStateType.loaded) {
            throw CheckoutAddressStateLoadingError.fromUnexpectedState(
              checkoutAddressState: state,
            );
          }

          final BusinessSettingsStateLoaded businessSettingsStateLoaded =
              businessSettingsBloc.state as BusinessSettingsStateLoaded;

          emit(CheckoutAddressStateLoaded.updateTrnCheckoutAddress(
            trnCheckout: checkoutBloc.state.trnCheckout,
            maxDeliveryDistance:
                businessSettingsStateLoaded.maxDeliveryDistance,
            trnCheckoutAddress: TrnCheckoutAddress(
              company: '',
              companyNumber: '',
              addressNote: event.address.addressNote,
              street: event.address.street,
              extended: event.address.extended,
              locality: event.address.locality,
              region: event.address.region,
              postalCode: event.address.postalCode,
              country: event.address.country,
              lat: event.address.lat,
              lng: event.address.lng,
              distance: event.address.distance,
            ),
          ));

        } on CheckoutAddressStateLoadingError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutAddressStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutAddressStateLoadingError.fromState(
          checkoutAddressState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutAddressEventSubmit>((event, emit) async {
      if (state is CheckoutAddressStateViewModel) {
        final CheckoutAddressStateViewModel stateViewModel =
            state as CheckoutAddressStateViewModel;
        try {
          emit(CheckoutAddressStateProgressError.fromViewModel(
            viewModel: stateViewModel,
          ));

          checkoutBloc.add(CheckoutEventUpdateAddress(
            trnCheckoutAddress: stateViewModel.trnCheckoutAddress!,
          ));

          final CheckoutState nextCheckoutState = await checkoutBloc.stream
              .firstWhere((element) =>
                  element is CheckoutStateIdle ||
                  element is CheckoutStateLoadingError ||
                  element is CheckoutStateProgressError);

          if (nextCheckoutState is CheckoutStateLoadingError) {
            throw CheckoutAddressStateProgressError(
                trnCheckoutAddress: stateViewModel.trnCheckoutAddress,
                validAddressDistance: stateViewModel.validAddressDistance,
                checkoutAddressViewType: stateViewModel.checkoutAddressViewType,
                error: nextCheckoutState.error);
          } else if (nextCheckoutState is CheckoutStateProgressError) {
            throw CheckoutAddressStateProgressError(
                trnCheckoutAddress: stateViewModel.trnCheckoutAddress,
                validAddressDistance: stateViewModel.validAddressDistance,
                checkoutAddressViewType: stateViewModel.checkoutAddressViewType,
                error: nextCheckoutState.error);
          }

          checkoutStepperBloc.add(CheckoutStepperEventNext());
        } on CheckoutAddressStateProgressError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutAddressStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutAddressStateLoadingError.fromState(
          checkoutAddressState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final CheckoutNavCubit checkoutNavCubit;
  final CheckoutBloc checkoutBloc;
  final CheckoutStepperBloc checkoutStepperBloc;
  final BusinessSettingsBloc businessSettingsBloc;
}
