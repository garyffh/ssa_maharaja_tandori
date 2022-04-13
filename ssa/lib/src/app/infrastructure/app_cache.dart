import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCache extends CacheManager with ImageCacheManager {
  factory AppCache() {
    return _instance;
  }

  AppCache._()
      : super(Config(
    key,
  ));

  static const key = 'appCacheData';
  static final AppCache _instance = AppCache._();

}
