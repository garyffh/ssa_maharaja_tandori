import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/business/period_day.dart';
import 'package:single_store_app/src/app/models/business/store_trading_exception_read.dart';
import 'package:single_store_app/src/app/models/business/trading_day.dart';

@immutable
abstract class TradingHoursState extends ProgressErrorState {
  const TradingHoursState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class TradingHoursStateInitial extends TradingHoursState {
  const TradingHoursStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class TradingHoursStateLoadingError extends TradingHoursState {
  const TradingHoursStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class TradingHoursStateViewModel extends TradingHoursState {
  const TradingHoursStateViewModel({
    required this.hasTradingHours,
    required this.storeDays,
    required this.deliveryDays,
    required this.periodDays,
    required this.tradingExceptions,

  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final bool hasTradingHours;
  final List<TradingDay> storeDays;
  final List<TradingDay> deliveryDays;
  final List<PeriodDay> periodDays;


  final List<StoreTradingExceptionRead> tradingExceptions;

  bool get hasDelivery => deliveryDays.isNotEmpty;
  bool get hasPeriod => periodDays.isNotEmpty;

  bool get hasTradingExceptions => tradingExceptions.isNotEmpty;

}
