import 'package:cakes_store_frontend/core/components/navigation_bar.dart';
import 'package:cakes_store_frontend/core/services/preference_manager.dart';
import 'package:cakes_store_frontend/core/theme/dark_theme.dart';
import 'package:cakes_store_frontend/core/theme/light_theme.dart';
import 'package:cakes_store_frontend/core/theme/theme_controller.dart';
import 'package:cakes_store_frontend/test_screens/theme_showcase_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  await ThemeController().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (_, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'YumSlice',
          themeMode: value,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: NavigationBarScreen(),
          //home: ThemeShowcaseScreen(),
        );
      },
    );
  }
}
