import 'package:app/app_module.dart';
import 'package:app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // KHởi tạo router chạy đầu tiên
  AppModule().initRoute();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  );
}
