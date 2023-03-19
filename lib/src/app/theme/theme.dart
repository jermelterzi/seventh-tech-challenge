part of '../seventh_app.dart';

ThemeData get _darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _darkColorScheme.primaryContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: _darkColorScheme.secondary,
            width: 2,
          ),
        ),
      ),
    );

ThemeData get _lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _lightColorScheme.primaryContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: _lightColorScheme.secondary,
            width: 2,
          ),
        ),
      ),
    );
