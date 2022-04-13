import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/app_day.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/string_extensions.dart';
import 'package:single_store_app/src/app/main/repos/home/trading_hours_repo.dart';
import 'package:single_store_app/src/app/models/business/delivery_period_read.dart';
import 'package:single_store_app/src/app/models/business/delivery_time_read.dart';
import 'package:single_store_app/src/app/models/business/period_day.dart';
import 'package:single_store_app/src/app/models/business/period_interval.dart';
import 'package:single_store_app/src/app/models/business/store_time_read.dart';
import 'package:single_store_app/src/app/models/business/store_trading_exception_read.dart';
import 'package:single_store_app/src/app/models/business/trading_day.dart';
import 'package:single_store_app/src/app/models/business/trading_interval.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

import 'trading_hours_event.dart';
import 'trading_hours_state.dart';

class TradingHoursBloc extends Bloc<TradingHoursEvent, TradingHoursState> {
  TradingHoursBloc({
    required this.tradingHoursRepo,
    required this.businessSettingsBloc,
  }) : super(const TradingHoursStateInitial()) {
    on<TradingHoursEventGetViewModel>((event, emit) async {
      try {
        if (businessSettingsBloc.state.runtimeType !=
            BusinessSettingsStateLoaded) {
          return;
        }

        final BusinessSettingsStateLoaded businessSettingsStateLoaded =
            businessSettingsBloc.state as BusinessSettingsStateLoaded;

        emit(const TradingHoursStateLoadingError());

        final List<StoreTimeRead> storeTimes =
            await tradingHoursRepo.allStoreTimes();

        late List<TradingDay> deliveryDays;
        late List<PeriodDay> periodDays;

        if (businessSettingsStateLoaded.useDeliveryPeriods) {
          deliveryDays = List.empty();
          periodDays = _periodDays(await tradingHoursRepo.allDeliveryPeriods());
        } else {
          deliveryDays =
              _deliveryDays(await tradingHoursRepo.allDeliveryTimes());
          periodDays = List.empty();
        }

        final List<StoreTradingExceptionRead> tradingExceptions =
            await tradingHoursRepo.allTradingExceptions();

        emit(TradingHoursStateViewModel(
          hasTradingHours: storeTimes.isNotEmpty,
          storeDays: _storeDays(storeTimes),
          deliveryDays: deliveryDays,
          periodDays: periodDays,
          tradingExceptions: tradingExceptions,
        ));
      } catch (e) {
        emit(TradingHoursStateLoadingError(error: e));
      }
    });
  }

  final TradingHoursRepo tradingHoursRepo;
  final BusinessSettingsBloc businessSettingsBloc;

  List<TradingDay> _storeDays(List<StoreTimeRead> storeTimes) {
    return List<TradingDay>.generate(
      AppDay.values.length,
      (dayIndex) {
        final List<StoreTimeRead> dayIntervals = storeTimes
            .where((element) => element.sysStoreTimeId == dayIndex)
            .toList(growable: false);
        return TradingDay(
          value: dayIndex,
          day: AppDay.values[dayIndex].text,
          intervals: List<TradingInterval>.generate(
            dayIntervals.length,
            (intervalIndex) {
              return TradingInterval(
                number: dayIntervals[intervalIndex].number,
                fromTime: dayIntervals[intervalIndex].fromTime.toTimeOfDay(),
                toTime: dayIntervals[intervalIndex].toTime.toTimeOfDay(),
              );
            },
          ),
        );
      },
    );
  }

  List<TradingDay> _deliveryDays(List<DeliveryTimeRead> deliveryTimes) {
    return List<TradingDay>.generate(
      AppDay.values.length,
      (dayIndex) {
        final List<DeliveryTimeRead> dayIntervals = deliveryTimes
            .where((element) => element.sysDeliveryTimeId == dayIndex)
            .toList(growable: false);
        return TradingDay(
          value: dayIndex,
          day: AppDay.values[dayIndex].text,
          intervals: List<TradingInterval>.generate(
            dayIntervals.length,
            (intervalIndex) {
              return TradingInterval(
                number: dayIntervals[intervalIndex].number,
                fromTime: dayIntervals[intervalIndex].fromTime.toTimeOfDay(),
                toTime: dayIntervals[intervalIndex].toTime.toTimeOfDay(),
              );
            },
          ),
        );
      },
    );
  }

  List<PeriodDay> _periodDays(List<DeliveryPeriodRead> periodTimes) {
    return List<PeriodDay>.generate(
      AppDay.values.length,
      (dayIndex) {
        final List<DeliveryPeriodRead> dayIntervals = periodTimes
            .where((element) => element.sysDeliveryPeriodId == dayIndex)
            .toList(growable: false);
        return PeriodDay(
          value: dayIndex,
          day: AppDay.values[dayIndex].text,
          intervals: List<PeriodInterval>.generate(
            dayIntervals.length,
            (intervalIndex) {
              return PeriodInterval(
                number: dayIntervals[intervalIndex].number,
                fromTime: dayIntervals[intervalIndex].fromTime.toTimeOfDay(),
                toTime: dayIntervals[intervalIndex].toTime.toTimeOfDay(),
                orderBeforeDay: dayIntervals[intervalIndex].orderBeforeDay,
                orderBeforeTime:
                    dayIntervals[intervalIndex].orderBeforeTime.toTimeOfDay(),
              );
            },
          ),
        );
      },
    );
  }
}
