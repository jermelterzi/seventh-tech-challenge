import 'package:flutter/material.dart';
import 'package:video_monitoring_seventh/src/app/seventh_app.dart';
import 'package:video_monitoring_seventh/src/core/dependency_injection/dependency_injection.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const SeventhApp());
}
