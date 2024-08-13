import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../core.dart';

class SharedPref {
  static Future<dynamic> get({
    required String key,
    dynamic defaultValue,
    PrefType type = PrefType.string,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case PrefType.string:
        return prefs.getString(key) ?? defaultValue;
      case PrefType.int:
        return prefs.getInt(key) ?? defaultValue;
      case PrefType.bool:
        return prefs.getBool(key) ?? defaultValue;
      case PrefType.double:
        return prefs.getDouble(key) ?? defaultValue;
      default:
        String jsonString = prefs.getString(key) ?? defaultValue;
        return jsonString.isNotEmpty ? json.decode(jsonString) : null;
    }
  }

  static Future<void> set({
    required String key,
    required dynamic value,
    PrefType type = PrefType.string,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case PrefType.string:
        await prefs.setString(key, value.toString());
        break;
      case PrefType.int:
        await prefs.setInt(key, value);
        break;
      case PrefType.bool:
        await prefs.setBool(key, value);
        break;
      case PrefType.double:
        await prefs.setDouble(key, value);
        break;
      default:
        String jsonString = json.encode(value);
        await prefs.setString(key, jsonString);
    }
  }

  static Future<void> remove({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> removeAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
