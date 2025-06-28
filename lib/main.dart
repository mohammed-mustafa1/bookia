import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/core/utils/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPrefs.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.routers,
      theme: AppTheme.lightTheme,
    );
  }
}
