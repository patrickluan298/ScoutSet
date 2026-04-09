import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static const String _preferenceKey = 'theme_mode';
  static final ThemeController instance = ThemeController._();

  SharedPreferences? _preferences;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> initialize({SharedPreferences? preferences}) async {
    _preferences ??= preferences ?? await SharedPreferences.getInstance();
    _themeMode = _readThemeMode(_preferences!);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) {
      return;
    }

    _themeMode = mode;
    notifyListeners();
    await _preferences?.setString(_preferenceKey, mode.name);
  }

  Future<void> toggleTheme() async {
    await setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  @visibleForTesting
  Future<void> resetForTesting({SharedPreferences? preferences}) async {
    _preferences = preferences;
    _themeMode =
        preferences == null ? ThemeMode.light : _readThemeMode(preferences);
    notifyListeners();
  }

  ThemeMode _readThemeMode(SharedPreferences preferences) {
    final saved = preferences.getString(_preferenceKey);
    return saved == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.light;
  }
}
