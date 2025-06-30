import 'dart:convert';

import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;
  static const String kToken = 'kToken';
  static const String kUserInfo = 'kUserInfo';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUserToken(String value) async {
    await setString(kToken, value);
  }

  static String getToken() => prefs.getString(kToken) ?? '';
  static Future<void> setUserInfo(User value) async {
    var userJson = value.toJson();
    String userString = json.encode(userJson);
    await setString(kUserInfo, userString);
  }

  static User getUserInfo() {
    var userString = getString(kUserInfo);
    var userJson = json.decode(userString);
    var user = User.fromJson(userJson);
    return user;
  }

  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getString(String key) => prefs.getString(key) ?? '';

  static Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}
