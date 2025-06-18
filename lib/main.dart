import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.routers,
      theme: AppTheme.darkTheme,
    );
  }
}
