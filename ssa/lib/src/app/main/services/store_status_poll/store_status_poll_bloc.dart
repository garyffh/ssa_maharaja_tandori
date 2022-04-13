import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/app_ticker.dart';
import 'package:single_store_app/src/app/main/services/store_status_poll/store_status_poll_event.dart';
import 'package:single_store_app/src/app/main/services/store_status_poll/store_status_poll_state.dart';

class StoreStatusPollBloc
    extends Bloc<StoreStatusPollEvent, StoreStatusPollState> {
  StoreStatusPollBloc() : super(const StoreStatusPollStateInitial(_duration)) {
    on<StoreStatusPollEventResetStart>((event, emit) async {
      _appTickerSubscription?.cancel();
      _appTickerSubscription = _appTicker.tick(ticks: _duration).listen(
          (duration) => add(StoreStatusPollEventTick(duration: duration)));

      emit(const StoreStatusPollStateRunInProgress(_duration));
    });

    on<StoreStatusPollEventPause>((event, emit) async {
      if (state is StoreStatusPollStateRunInProgress) {
        _appTickerSubscription?.pause();
        emit(StoreStatusPollStateRunPaused(state.duration));
      }
    });

    on<StoreStatusPollEventResume>((event, emit) async {
      if (state is StoreStatusPollStateRunPaused) {
        _appTickerSubscription?.resume();
        emit(StoreStatusPollStateRunInProgress(state.duration));
      }
    });

    on<StoreStatusPollEventReset>((event, emit) async {
      _appTickerSubscription?.cancel();
      emit(const StoreStatusPollStateInitial(_duration));
    });

    on<StoreStatusPollEventTick>((event, emit) async {

      if (event.duration > 0) {
        emit(StoreStatusPollStateRunInProgress(event.duration));
      } else {
        emit(const StoreStatusPollStateRunCompleted());
        add(StoreStatusPollEventResetStart());
      }
    });
  }

  final AppTicker _appTicker = const AppTicker();
  static const int _duration = 360;

  StreamSubscription<int>? _appTickerSubscription;

  @override
  Future<void> close() {
    _appTickerSubscription?.cancel();
    return super.close();
  }
}
