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
    try {
      await AuthRepo.registerUser(registerParams: authParams).then((value) {
        if (value != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Something went wrong'));
        }
      });
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  login() async {
    authParams = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );
    emit(AuthLoading());
    try {
      await AuthRepo.loginUser(loginParams: authParams).then((value) {
        if (value != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Something went wrong'));
        }
      });
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  forgotPassword() async {
    authParams = AuthParams(
      email: emailController.text,
    );
    emit(AuthLoading());
    try {
      await AuthRepo.forgotPassword(forgotPasswordParams: authParams)
          .then((value) {
        if (value) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Something went wrong'));
        }
      });
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  otpVerification() async {
    authParams = AuthParams(
      email: emailController.text,
      verifyCode: otpController.text,
    );
    emit(AuthLoading());
    try {
      await AuthRepo.otpVerification(otpVerificationParams: authParams)
          .then((value) {
        if (value) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Something went wrong'));
        }
      });
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }

  createNewPassword() async {
    authParams = AuthParams(
        verifyCode: otpController.text,
        newPassword: passwordController.text,
        newPasswordConfirmation: passwordConfirmationController.text);
    emit(AuthLoading());
    try {
      await AuthRepo.resetPassword(resetPasswordParams: authParams)
          .then((value) {
        if (value) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Something went wrong'));
        }
      });
    } catch (e) {
      emit(AuthError('Something went wrong'));
    }
  }
}
