import 'package:flutter/material.dart';
import 'package:video_monitoring_seventh/src/app/routes/routes.dart';

part 'theme/theme.dart';
part 'theme/color_schemes.g.dart';

class SeventhApp extends StatelessWidget {
  const SeventhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      routes: AppRoutes.routes,
    );
  }
}
