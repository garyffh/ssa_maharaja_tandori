
import 'package:single_store_app/src/app/models/business/period_interval.dart';

class PeriodDay {
  PeriodDay({
    required this.value,
    required this.day,
    required this.intervals,
  });

  final int value;
  final String day;
  final List<PeriodInterval> intervals;

}
