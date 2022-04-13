class PackageConstants {
  PackageConstants._();

  static const String appId = String.fromEnvironment(
    'SINGLE_STORE_APP_APP_ID',
  );

  static const String appName = String.fromEnvironment(
    'SINGLE_STORE_APP_APP_NAME',
  );

  static const String clientId = String.fromEnvironment(
    'SINGLE_STORE_APP_CLIENT_ID',
  );
  static const String webSiteUrl = String.fromEnvironment(
    'SINGLE_STORE_APP_WEB_SITE_URL',
  );
  static const String url = String.fromEnvironment(
    'SINGLE_STORE_APP_URL',
  );
  static const String apiSegment = String.fromEnvironment(
    'SINGLE_STORE_APP_API_SEGMENT',
  );
  static const int logoBackgroundColour = int.fromEnvironment(
    'SINGLE_STORE_APP_API_LOGO_BACKGROUND_COLOUR',
  );
}
