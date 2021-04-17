import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:project_habits/themes/base_theme.dart';
import 'package:project_habits/utils/stream_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const THEME_STATUS_KEY = "theme-status";
  static const THEME_COLOR_KEY = "theme-color";

  late final SharedPreferences _sharedPreferences;

  late ThemeStatus _themeStatus;
  ThemeStatus get themeStatus => _themeStatus;

  late ThemeColors _themeColor;
  ThemeColors get themeColor => _themeColor;

  late StreamData<ThemeData> theme = StreamData(initialValue: lightTheme);

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _themeColor = _getSavedThemeColor();
    updateThemeStatus(_getSavedThemeStatus());
  }

  void updateThemeStatus(ThemeStatus newStatus) {
    _themeStatus = newStatus;
    switch(_themeStatus) {
      case ThemeStatus.light:
        _enabledLight();
        break;
      case ThemeStatus.dark:
        _enabledDark();
        break;
      case ThemeStatus.auto:
        if(SchedulerBinding.instance!.window.platformBrightness == Brightness.dark) {
          _enabledDark();
        } else {
          _enabledLight();
        }
        break;
    }
    _saveThemeStatus(newStatus);
  }

  void updateThemeColor(ThemeColors newThemeColor) {
    _themeColor = newThemeColor;
    _saveThemeColor(newThemeColor);
    updateThemeStatus(_themeStatus);
  }

  void _enabledDark() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark
    ));
    theme.add(getDarkTheme(themeColor));
  }

  void _enabledLight() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light
    ));
    theme.add(getLightTheme(themeColor));
  }

  void _saveThemeStatus(ThemeStatus newStatus) {
    _sharedPreferences.setInt(THEME_STATUS_KEY, newStatus.index);
  }

  ThemeStatus _getSavedThemeStatus() {
    return ThemeStatus.values[_sharedPreferences.getInt(THEME_STATUS_KEY) ?? 0];
  }

  void _saveThemeColor(ThemeColors newThemeColor) {
    _sharedPreferences.setInt(THEME_COLOR_KEY, newThemeColor.index);
  }

  ThemeColors _getSavedThemeColor() {
    return ThemeColors.values[_sharedPreferences.getInt(THEME_COLOR_KEY) ?? 0];
  }
}

enum ThemeStatus {
  light,
  dark,
  auto
}