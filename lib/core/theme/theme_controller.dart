import 'package:cakes_store_frontend/core/constants/preferences_keys.dart';
import 'package:cakes_store_frontend/core/services/preference_manager.dart';
import 'package:flutter/material.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  init() {
    bool result = PreferencesManager().getBool(PreferencesKeys.theme) ?? false;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool(PreferencesKeys.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool(PreferencesKeys.theme, true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
