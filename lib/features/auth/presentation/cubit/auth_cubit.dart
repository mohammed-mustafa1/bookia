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
  late AuthParams authParams;
  register() {
    authParams = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
    );
    emit(AuthLoading());
    try {
      AuthRepo.registerUser(registerParams: authParams).then((value) {
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

  login() {
    authParams = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );
    emit(AuthLoading());
    try {
      AuthRepo.loginUser(loginParams: authParams).then((value) {
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
}
