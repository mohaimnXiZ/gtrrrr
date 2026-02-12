import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class ThemeManager {
  static const String _key = 'theme_mode';

  static Future<void> init(SharedPreferences prefs) async {
    final savedTheme = prefs.getString(_key);
    if (savedTheme == 'dark') {
      themeNotifier.value = ThemeMode.dark;
    } else if (savedTheme == 'light') {
      themeNotifier.value = ThemeMode.light;
    } else {
      themeNotifier.value = ThemeMode.system;
    }
  }

  static void toggleTheme(SharedPreferences? prefs) {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
    } else {
      themeNotifier.value = ThemeMode.dark;
    }
    prefs?.setString(_key, themeNotifier.value == ThemeMode.dark ? 'dark' : 'light');
  }
}
