import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/store_status_repo.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_event.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/services/store_status_poll/store_status_poll_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status_poll/store_status_poll_event.dart';
import 'package:single_store_app/src/app/main/services/store_status_poll/store_status_poll_state.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';
import 'package:single_store_app/src/app/models/business/store_status_find.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

class StoreStatusBloc extends Bloc<StoreStatusEvent, StoreStatusState> {
  StoreStatusBloc({
    required this.storeStatusPollBloc,
    required this.storeStatusRepo,
    required this.businessSettingsBloc,
  }) : super(const StoreStatusStatePending()) {
    on<StoreStatusEventInitialise>((event, emit) async {
      if (businessSettingsBloc.state is BusinessSettingsStateLoaded) {
        final BusinessSettingsStateLoaded businessSettingsStateLoaded =
            businessSettingsBloc.state as BusinessSettingsStateLoaded;

        emit(StoreStatusStateLoaded(
          storeStatus: businessSettingsStateLoaded.storeStatus.copyWith(),
          timeZone: businessSettingsStateLoaded.timeZone,
        ));

        storeStatusPollBloc.add(StoreStatusPollEventResetStart());
      }
    });

    on<StoreStatusEventRefresh>((event, emit) async {
      try {
        storeStatusPollBloc.add(StoreStatusPollEventReset());

        if (!state.loaded) {
          return;
        }

        emit(StoreStatusStateLoaded(
          storeStatus: await storeStatusRepo.findStoreStatus(
            StoreStatusFind(timeZone: state.timeZone),
          ),
          timeZone: state.timeZone,
        ));
      } catch (_) {
      } finally {
        storeStatusPollBloc.add(StoreStatusPollEventResetStart());
      }
    });

    on<StoreStatusEventUpdate>((event, emit) async {
      storeStatusPollBloc.add(StoreStatusPollEventReset());

      emit(StoreStatusStateLoaded(
        storeStatus: event.storeStatus,
        timeZone: event.timeZone,
      ));

      storeStatusPollBloc.add(StoreStatusPollEventResetStart());
    });

    on<StoreStatusEventImmediateRefresh>((event, emit) async {
      try {
        storeStatusPollBloc.add(StoreStatusPollEventReset());

        if (!state.loaded) {
          throw AppException.fromString('The store status is not available');
        }

        final StoreStatusStateLoaded storeStatusStateLoaded =
            state as StoreStatusStateLoaded;

        try {
          emit(StoreStatusStateLoaded(
            storeStatus: await storeStatusRepo.findStoreStatus(
              StoreStatusFind(timeZone: state.timeZone),
            ),
            timeZone: state.timeZone,
          ));
        } catch (e) {
          emit(StoreStatusStateImmediateRefreshError(
            storeStatus: storeStatusStateLoaded.storeStatus,
            timeZone: storeStatusStateLoaded.timeZone,
            error: e,
          ));
        }
      } catch (e) {
        emit(StoreStatusStatePendingError(error: e));
      } finally {
        storeStatusPollBloc.add(StoreStatusPollEventResetStart());
      }
    });

    businessSettingsSubscription = businessSettingsBloc.stream.listen((state) {
      if (state is BusinessSettingsStateLoaded) {
        add(StoreStatusEventUpdate(
          storeStatus: state.storeStatus.copyWith(),
          timeZone: state.timeZone,
        ));
      }
    });

    storeStatusPollSubscription = storeStatusPollBloc.stream.listen((state) {
      if (state is StoreStatusPollStateRunCompleted) {
        add(StoreStatusEventRefresh());
      }
    });
  }

  final StoreStatusPollBloc storeStatusPollBloc;
  final StoreStatusRepo storeStatusRepo;
  final BusinessSettingsBloc businessSettingsBloc;

  late StreamSubscription storeStatusPollSubscription;
  late StreamSubscription businessSettingsSubscription;


  @override
  Future<void> close() {
    storeStatusPollSubscription.cancel();
    businessSettingsSubscription.cancel();
    return super.close();
  }
}
