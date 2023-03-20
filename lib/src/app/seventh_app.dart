import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_monitoring_seventh/src/app/routes/routes.dart';
import 'package:video_monitoring_seventh/src/core/dependency_injection/dependency_injection.dart'
    as di;
import 'package:video_monitoring_seventh/src/features/auth/presentation/bloc/auth_bloc.dart';

part 'theme/theme.dart';
part 'theme/color_schemes.g.dart';

class SeventhApp extends StatelessWidget {
  const SeventhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.dependencyAssembly<AuthBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: _lightTheme,
        darkTheme: _darkTheme,
        routes: AppRoutes.routes,
      ),
    );
  }
}
