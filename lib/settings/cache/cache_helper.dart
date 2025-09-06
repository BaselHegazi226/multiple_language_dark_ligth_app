import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper implements SettingProcesses {
  //1. singleton pattern
  static final CacheHelper _instance = CacheHelper._internal();
  factory CacheHelper() => _instance;
  CacheHelper._internal();

  //2. initialization shared preference
  late SharedPreferences _sharedPreferences;
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //3. methods

  //a.. save data
  @override
  Future<void> saveData({required String key, required value}) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else {
      await _sharedPreferences.setStringList(key, value);
    }
  }

  @override
  Future<void> saveTheme({required String key, required String value}) async {
    await _sharedPreferences.setString(key, value);
  }

  //b.. get data by key
  @override
  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  //c.. remove data by key
  @override
  Future<void> removeDataByKey({required String key}) async {
    _sharedPreferences.remove(key);
  }

  //d.. remove all
  @override
  Future<void> removeAllData() async {
    _sharedPreferences.clear();
  }
}

abstract class SettingProcesses {
  dynamic saveData({required String key, required dynamic value});
  dynamic saveTheme({required String key, required String value});
  dynamic getData({required String key});
  Future<void> removeDataByKey({required String key});
  Future<void> removeAllData();
}
