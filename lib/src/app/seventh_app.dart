import 'package:flutter/material.dart';
import 'package:video_monitoring_seventh/src/app/routes/routes.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/pages/auth_page.dart';
import 'package:video_monitoring_seventh/src/features/video_player/presentation/pages/video_player_page.dart';

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
