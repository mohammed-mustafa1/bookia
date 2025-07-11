import 'package:bookia/bloc_observer.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/core/utils/theme.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPrefs.init();
  Bloc.observer = Observer();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouter.routers,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: SharedPrefs.getTheme);
          },
        ));
  }
}
