import 'package:flutter/material.dart';
import 'package:project_habits/pages/home_page/home_page.dart';
import 'package:project_habits/services/data_service.dart';
import 'package:get_it/get_it.dart';
import 'package:project_habits/services/theme_service.dart';
import 'package:project_habits/widgets/life_cycle_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dataService = DataService();
  await dataService.init();
  GetIt.I.registerSingleton(dataService);

  final themeService = ThemeService();
  await themeService.init();
  GetIt.I.registerSingleton(themeService);

  WidgetsBinding.instance!.addObserver(
    LifeCycleHandler(
      resumeCallBack: () async => themeService.updateThemeStatus(themeService.themeStatus)
    )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = GetIt.I.get<ThemeService>();

    return StreamBuilder<ThemeData>(
      stream: themeService.theme.stream,
      initialData: themeService.theme.value,
      builder: (context, snapshot) {
        return AnimatedTheme(
          duration: const Duration(milliseconds: 500),
          data: snapshot.data!,
          child: MaterialApp(
            theme: snapshot.data,
            home: HomePage()
          ),
        );
      }
    );
  }
}