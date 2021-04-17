import 'package:get_it/get_it.dart';
import 'package:project_habits/services/theme_service.dart';
import 'package:project_habits/themes/base_theme.dart';
import 'package:project_habits/utils/stream_data.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsDialogController {
  final ThemeService _themeService = GetIt.I.get<ThemeService>();

  ThemeStatus get themeStatus => _themeService.themeStatus;

  late final StreamData<ThemeColors> selectedColor;

  SettingsDialogController() {
    selectedColor = StreamData(initialValue: _themeService.themeColor);
  }

  void changeThemeStatus(int newValue) {
    _themeService.updateThemeStatus(ThemeStatus.values[newValue]);
  }

  void changeThemeColor(ThemeColors newColor) {
    selectedColor.add(newColor);
    _themeService.updateThemeColor(newColor);
  }

  void openGithub() {
    launch("https://github.com/GiacomoPignoni/habits_diary");
  }

  void dispose() {
    selectedColor.close();
  }
}