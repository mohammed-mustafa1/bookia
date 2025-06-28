import 'package:bookia/features/auth/data/model/request/auth_params.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController otpController = TextEditingController();
  late AuthParams authParams;
  register() async {
    authParams = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
    );
    emit(AuthLoading());

    await AuthRepo.registerUser(registerParams: authParams).then((value) {
      return value.fold((error) {
        emit(AuthError(error.message));
      }, (response) {
        emit(AuthSuccess());
      });
    });
  }

  login() async {
    authParams = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );
    emit(AuthLoading());
    await AuthRepo.loginUser(loginParams: authParams).then((value) {
      return value.fold((error) {
        emit(AuthError(error.message));
      }, (response) {
        emit(AuthSuccess());
      });
    });
  }

  forgotPassword() async {
    authParams = AuthParams(
      email: emailController.text,
    );
    emit(AuthLoading());

    await AuthRepo.forgotPassword(forgotPasswordParams: authParams)
        .then((value) {
      return value.fold(
        (error) => emit(AuthError(error.message)),
        (response) => emit(AuthSuccess()),
      );
    });
  }

  otpVerification() async {
    authParams = AuthParams(
      email: emailController.text,
      verifyCode: otpController.text,
    );
    emit(AuthLoading());
    await AuthRepo.otpVerification(otpVerificationParams: authParams)
        .then((value) {
      value.fold((error) {
        emit(AuthError(error.message));
      }, (response) {
        emit(AuthSuccess());
      });
    });
  }

  createNewPassword() async {
    authParams = AuthParams(
        verifyCode: otpController.text,
        newPassword: passwordController.text,
        newPasswordConfirmation: passwordConfirmationController.text);
    emit(AuthLoading());
    await AuthRepo.resetPassword(resetPasswordParams: authParams).then((value) {
      value.fold((error) {
        emit(AuthError(error.message));
      }, (response) {
        emit(AuthSuccess());
      });
    });
  }
}
