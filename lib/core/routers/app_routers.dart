import 'package:bookia/features/auth/presentation/pages/create_new_password_screen.dart';
import 'package:bookia/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:bookia/features/auth/presentation/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:bookia/features/auth/presentation/pages/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/pages/register_screen.dart';
import 'package:bookia/features/home/presentation/pages/book_details_screen.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/main/presentation/pages/main_screen.dart';
import 'package:bookia/features/intro/splash_screen.dart';
import 'package:bookia/features/intro/welcome_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String createNewPassword = '/create-new-password';
  static const String passwordChanged = '/password-changed';
  static const String mainScreen = '/main-screen';
  static const String bookDetails = '/book-details';

  static final routers = GoRouter(routes: [
    GoRoute(path: splash, builder: (context, state) => SplashScreen()),
    GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
    GoRoute(path: login, builder: (context, state) => LoginScreen()),
    GoRoute(path: register, builder: (context, state) => RegisterScreen()),
    GoRoute(
        path: forgotPassword,
        builder: (context, state) => ForgotPasswordScreen()),
    GoRoute(
      path: otpVerification,
      builder: (context, state) =>
          OtpVerificationScreen(email: state.extra as String),
    ),
    GoRoute(
        path: createNewPassword,
        builder: (context, state) =>
            CreateNewPasswordScreen(pinCode: state.extra as String)),
    GoRoute(
        path: passwordChanged,
        builder: (context, state) => PasswordChangedScreen()),
    GoRoute(path: mainScreen, builder: (context, state) => MainScreen()),
    GoRoute(
        path: bookDetails,
        builder: (context, state) => BookDetailsScreen(
              book: state.extra as Product,
            )),
  ]);
}
