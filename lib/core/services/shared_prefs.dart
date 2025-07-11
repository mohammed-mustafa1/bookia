import 'dart:convert';

import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;
  static const String kToken = 'kToken';
  static const String kUserInfo = 'kUserInfo';
  static const String kThemeMode = 'kThemeMode';
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

  static User? getUserInfo() {
    var userString = getString(kUserInfo);
    if (userString.isEmpty || userString == '') {
      return null;
    }
    var userJson = json.decode(userString);
    var user = User.fromJson(userJson);
    return user;
  }

  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getString(String key) => prefs.getString(key) ?? '';

  static Future<void> removeUserData() async {
    await prefs.remove(kToken);
    await prefs.remove(kThemeMode);
    await prefs.remove(kUserInfo);
  }

  static setTheme({required ThemeMode themeMode}) {
    setString(kThemeMode, themeMode.name);
  }

  static ThemeMode get getTheme {
    final themeName = getString(kThemeMode);
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}
