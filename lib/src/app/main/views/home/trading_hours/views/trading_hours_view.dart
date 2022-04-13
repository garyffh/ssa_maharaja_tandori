import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/trading_hours_repo.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/models/business/period_day.dart';
import 'package:single_store_app/src/app/models/business/period_interval.dart';
import 'package:single_store_app/src/app/models/business/store_trading_exception_read.dart';
import 'package:single_store_app/src/app/models/business/trading_day.dart';
import 'package:single_store_app/src/app/models/business/trading_interval.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/column_builder.dart';
import 'package:single_store_app/src/app/widgets/ui/heading_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/title_action_button.dart';

import 'trading_hours_bloc.dart';
import 'trading_hours_event.dart';
import 'trading_hours_state.dart';

class TradingHoursView extends StatelessWidget {
  const TradingHoursView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TradingHoursBloc(
        tradingHoursRepo: RepositoryProvider.of<TradingHoursRepo>(context),
        businessSettingsBloc: BlocProvider.of<BusinessSettingsBloc>(context),
      )..add(TradingHoursEventGetViewModel()),
      child: BlocBuilder<TradingHoursBloc, TradingHoursState>(
        builder: (viewContext, state) {
          return _view(viewContext, state);
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, TradingHoursState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as TradingHoursStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return Align(
            alignment: Alignment.center,
            child: ProgressErrorWidget(
              progressErrorState: viewState,
              dataDirection: DataDirection.receiving,
              tryAgainCallback: () => viewContext
                  .read<TradingHoursBloc>()
                  .add(TradingHoursEventGetViewModel()),
            ),
          );
        }

      case ProgressErrorStateType.progressError:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    TradingHoursStateViewModel viewModel,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _storeHours(viewContext, viewModel.storeDays),
          if (viewModel.hasDelivery)
          _deliveryHours(viewContext, viewModel.deliveryDays),
          if (viewModel.hasPeriod)
          _deliveryPeriods(viewContext, viewModel.periodDays),
          if (viewModel.hasTradingExceptions)
            _exceptions(viewContext, viewModel.tradingExceptions),
        ],
      ),
    );
  }

  Widget _storeHours(BuildContext viewContext, List<TradingDay> tradingDays) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const HeadingWidget(
              heading: 'Store Hours',
            ),
            Padding(
              padding: EdgeInsets.all(
                viewContext.watch<MediaSettingsBloc>().state.sp(16),
              ),
              child: ColumnBuilder(
                itemCount: tradingDays.length,
                itemBuilder: (BuildContext context, int index) {
                  return _tradingDay(viewContext, tradingDays[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deliveryHours(
      BuildContext viewContext, List<TradingDay> tradingDays) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            HeadingWidget(
                heading: 'Delivery Hours',
                trailingWidget: TitleActionButton(
                  label: 'Delivery Areas',
                  iconData: Icons.place,
                  onPressed: () =>
                      viewContext.read<HomeNavCubit>().showDeliveryAreas(),
                )),
            Padding(
              padding: EdgeInsets.all(
                viewContext.watch<MediaSettingsBloc>().state.sp(16),
              ),
              child: ColumnBuilder(
                itemCount: tradingDays.length,
                itemBuilder: (BuildContext context, int index) {
                  return _tradingDay(viewContext, tradingDays[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deliveryPeriods(
      BuildContext viewContext, List<PeriodDay> periodDays) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            HeadingWidget(
              heading: 'Delivery Hours',
              trailingWidget: TitleActionButton(
                label: 'Delivery Areas',
                iconData: Icons.place,
                onPressed: () =>
                    viewContext.read<HomeNavCubit>().showDeliveryAreas(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                viewContext.watch<MediaSettingsBloc>().state.sp(16),
              ),
              child: ColumnBuilder(
                itemCount: periodDays.length,
                itemBuilder: (BuildContext context, int index) {
                  return _periodDay(viewContext, periodDays[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _exceptions(BuildContext viewContext,
      List<StoreTradingExceptionRead> tradingExceptions) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const HeadingWidget(
              heading: 'Additional Trading',
            ),
            Padding(
              padding: EdgeInsets.all(
                viewContext.watch<MediaSettingsBloc>().state.sp(16),
              ),
              child: ColumnBuilder(
                itemCount: tradingExceptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return _tradingException(
                      viewContext, tradingExceptions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tradingDay(BuildContext viewContext, TradingDay tradingDay) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: viewContext.watch<MediaSettingsBloc>().state.sp10),
      child: Column(
        children: [
          Text(
            tradingDay.day,
            style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
          ),
          _intervals(viewContext, tradingDay.intervals),
        ],
      ),
    );
  }

  Widget _intervals(BuildContext viewContext, List<TradingInterval> intervals) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: viewContext.watch<MediaSettingsBloc>().state.sp8),
      child: intervals.isEmpty
          ? Text(
              'Closed',
              style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
              textAlign: TextAlign.center,
            )
          : ColumnBuilder(
              itemCount: intervals.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  '${intervals[index].fromTime.format(viewContext)} to ${intervals[index].toTime.format(viewContext)}',
                  style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                  textAlign: TextAlign.center,
                );
              },
            ),
    );
  }

  Widget _periodDay(BuildContext viewContext, PeriodDay periodDay) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: viewContext.watch<MediaSettingsBloc>().state.sp10),
      child: Column(
        children: [
          Text(
            periodDay.day,
            style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
          ),
          _periodIntervals(viewContext, periodDay.intervals),
        ],
      ),
    );
  }

  Widget _periodIntervals(
      BuildContext viewContext, List<PeriodInterval> intervals) {
    return intervals.isEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(
                vertical: viewContext.watch<MediaSettingsBloc>().state.sp8),
            child: Text(
              'Closed',
              style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
              textAlign: TextAlign.center,
            ),
          )
        : ColumnBuilder(
            itemCount: intervals.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          viewContext.watch<MediaSettingsBloc>().state.sp8),
                  child: Text(
                    '${intervals[index].fromTime.format(viewContext)} to ${intervals[index].toTime.format(viewContext)}',
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          viewContext.watch<MediaSettingsBloc>().state.sp4),
                  child: Text(
                    'Order before: ${intervals[index].orderBeforeDay} ${intervals[index].orderBeforeTime.format(viewContext)}',
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]);
            },
          );
  }

  Widget _tradingException(
      BuildContext viewContext, StoreTradingExceptionRead tradingException) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: viewContext.watch<MediaSettingsBloc>().state.sp10),
          child: Text(
            tradingException.heading,
            style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: viewContext.watch<MediaSettingsBloc>().state.sp8),
          child: Text(
            tradingException.text,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
