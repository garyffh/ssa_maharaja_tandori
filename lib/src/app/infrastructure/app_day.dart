enum AppDay {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

extension AppDayExtension on AppDay {
  String get text {
    switch (this) {
      case AppDay.sunday:
        return 'Sunday';

      case AppDay.monday:
        return 'Monday';

      case AppDay.tuesday:
        return 'Tuesday';

      case AppDay.wednesday:
        return 'Wednesday';

      case AppDay.thursday:
        return 'Thursday';

      case AppDay.friday:
        return 'Friday';

      case AppDay.saturday:
        return 'Saturday';
    }
  }
}
