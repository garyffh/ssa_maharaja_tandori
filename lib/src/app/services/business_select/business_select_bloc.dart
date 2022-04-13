import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/multi_store/multi_store_settings.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';

import 'business_select_event.dart';
import 'business_select_state.dart';

class BusinessSelectBloc
    extends Bloc<BusinessSelectEvent, BusinessSelectState> {
  BusinessSelectBloc() : super(const BusinessSelectStatePending()) {
    on<BusinessSelectEventLoad>((event, emit) async {
      if (event.initialStateLoaded.isMultiStore) {
        emit(
          BusinessSelectStateLoaded.fromServerBusiness(
              event.initialStateLoaded),
        );
      } else {
        emit(
          BusinessSelectStateSelected(
              multiStoreSettings:
                  MultiStoreSettings.fromInitialState(event.initialStateLoaded),
              selectedIdentity:
                  event.initialStateLoaded.stores[0].businessIdentity),
        );
      }
    });

    on<BusinessSelectEventUnselect>((event, emit) async {
      if (state.type == BusinessSelectStateType.selected) {
        final BusinessSelectStateView businessSelectStateView =
            state as BusinessSelectStateView;

        emit(
          BusinessSelectStateLoaded(
            multiStoreSettings: MultiStoreSettings.clone(
                businessSelectStateView.multiStoreSettings),
          ),
        );
      }

    });

    on<BusinessSelectEventSelect>((event, emit) async {
      if (state.type == BusinessSelectStateType.loaded) {
        final BusinessSelectStateLoaded businessSelectStateLoaded =
            state as BusinessSelectStateLoaded;

        final Iterable<StoreSettings> store = businessSelectStateLoaded
            .multiStoreSettings.stores
            .where((element) =>
                element.businessIdentity == event.selectedIdentity);
        if (store.isNotEmpty) {
          emit(
            BusinessSelectStateSelected(
                multiStoreSettings:
                    businessSelectStateLoaded.multiStoreSettings,
                selectedIdentity: event.selectedIdentity),
          );
        } else {
          // error here
        }
      } else {
        // error here
      }
    });
  }
}
