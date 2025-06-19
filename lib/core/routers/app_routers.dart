import 'package:bookia/features/auth/presentation/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/pages/register_screen.dart';
import 'package:bookia/features/intro/splash_screen.dart';
import 'package:bookia/features/intro/welcome_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static final routers = GoRouter(routes: [
    GoRoute(path: splash, builder: (context, state) => SplashScreen()),
    GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
    GoRoute(path: login, builder: (context, state) => LoginScreen()),
    GoRoute(path: register, builder: (context, state) => RegisterScreen()),
  ]);
}
