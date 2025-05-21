import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static Future<bool> setString(String key, String value) async {
   // var prefs = await _instance;
    return _prefsInstance!.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool> setList(String key, List<String> value) async {
    var prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  static String getString(String key) {
    return _prefsInstance?.getString(key) ?? "";
  }

  static bool getBool(String key) {
    return _prefsInstance?.getBool(key) ?? false;
  }

  static Future<bool> saveUserCustomerId(String customerId) async {
    var prefs = await _instance;
    return  prefs.setString("customerId", customerId);
  }

  static String getUserCustomerId() {
    return _prefsInstance!.getString("customerId") ?? "";
  }

  static bool isLoggedIn() {
    return _prefsInstance!.containsKey("token");
  }

  static Future<bool> saveUserToken(String token) async {
    var prefs = await _instance;
    return await prefs.setString("token", token);
  }

  Future<bool> clearSharedPref() {
    return _prefsInstance!.clear();
  }

  Future<bool> remove(String key) async {
    return _prefsInstance!.remove(key);
  }
}
