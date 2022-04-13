import 'package:shared_preferences/shared_preferences.dart';

class StorageRepo {
  StorageRepo();

  Future<bool> keyExists(String key) async {
    return  (await SharedPreferences.getInstance()).containsKey(key);
  }

  Future<void> removeKey(String key) async {
    if(await keyExists(key)) {
      (await SharedPreferences.getInstance()).remove(key);
    }
  }

  Future<int?> getInt(String key) async {
    return  (await SharedPreferences.getInstance()).getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    return (await SharedPreferences.getInstance()).setInt(key, value);
  }

  Future<double?> getDouble(String key) async {
    return  (await SharedPreferences.getInstance()).getDouble(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return (await SharedPreferences.getInstance()).setDouble(key, value);
  }

  Future<bool?> getBool(String key) async {
    return  (await SharedPreferences.getInstance()).getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return (await SharedPreferences.getInstance()).setBool(key, value);
  }

  Future<String?> getString(String key) async {
    return  (await SharedPreferences.getInstance()).getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return (await SharedPreferences.getInstance()).setString(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return  (await SharedPreferences.getInstance()).getStringList(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return (await SharedPreferences.getInstance()).setStringList(key, value);
  }

}
