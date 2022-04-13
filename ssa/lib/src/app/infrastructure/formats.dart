import 'package:intl/intl.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';

class Formats {
  Formats._();


  static String dayMonthTime(DateTime value) {
    return DateFormat.Md().add_jm().format(value.toLocal());
  }

  static String dayMonthYearTime(DateTime value) {
    return DateFormat.yMd().add_jm().format(value.toLocal());
  }

  static String dayMonthYear(DateTime value) {
    return DateFormat.yMd().format(value.toLocal());
  }

  static String dayMonth(DateTime value) {
    return DateFormat.Md().format(value.toLocal());
  }

  static String weekDayTime(DateTime value) {
    return '${DateFormat('E d').format(value.toLocal())} ${DateFormat.jm().format(value.toLocal())}';
  }

  static String weekDayMonthTime(DateTime value) {
    return '${DateFormat('E d/M').format(value.toLocal())} ${DateFormat.jm().format(value.toLocal())}';
  }

  static String weekDayMonth(DateTime value) {
    return DateFormat('E d/M').format(value.toLocal());
  }


  static String weekDayMonthText(DateTime value) {
    return DateFormat('E MMM d').format(value.toLocal());
  }

  static String time(DateTime value) {
    return DateFormat.jm().format(value.toLocal());
  }

  static String currency(double value) {
    return NumberFormat.simpleCurrency().format(value);
  }

  static String qty(double value) {
    return NumberFormat('#,###,###.###', AppConstants.defaultLocaleString).format(value);
  }

  static String points(int value) {
    return NumberFormat('#,###,###', AppConstants.defaultLocaleString).format(value);
  }

  static String minutes(int value) {
    return NumberFormat('#,###,###', AppConstants.defaultLocaleString).format(value);
  }

  static String emptyGuid() {
    return '00000000-0000-0000-0000-000000000000';
  }
}

