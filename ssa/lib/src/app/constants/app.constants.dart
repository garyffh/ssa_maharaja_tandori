import 'package:flutter/foundation.dart';

class AppConstants {
  AppConstants._();

  static const int version = 311;
  static const double maxBodyWidth = 1280;
  static const int debounceInterval = 750;

  static const String mainFont = fontRoboto;
  static const String fontRoboto = 'Roboto';

  static const String defaultLocaleString = 'en_AU';

  static const String currencyCode = 'AUD';

  static String get openingSoonMessage =>
      'We are preparing our online store, opening soon.';

  static String get offlineMessage =>
      'We are offline and not taking online orders, sorry for the inconvenience, we will back soon.';

  static String get driverNotAvailableMessage =>
      'All of our drivers are busy, our delivery service will resume shortly';

  static String get deliveryOfflineMessage =>
      'Deliveries are offline, our delivery service will resume soon';

  static String get storeOfflineMessage =>
      'Ordering ahead is offline, our order ahead service will resume shortly';

  static String get cartOfflineMessage =>
      'We are offline and not taking online orders, sorry for the inconvenience, we will back soon.';

  static String get cartClosedMessage =>
      'We are closed, please see our trading hours.';

  static String get cartOpeningSoonMessage =>
      'We are preparing our online store, opening soon.';

  static int get deliveryMethodInterval => 5;

  static bool get enabledMessagingPlatform =>
      defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS;

}


