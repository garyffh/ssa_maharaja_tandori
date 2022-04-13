
import 'package:single_store_app/src/app/models/business/trading_interval.dart';

class TradingDay {
  TradingDay({
    required this.value,
    required this.day,
    required this.intervals,
  });

  final int value;
  final String day;
  final List<TradingInterval> intervals;

}