import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/profile/data/repo/profile_repo.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController =
      TextEditingController();
  ThemeMode themeMode = SharedPrefs.getTheme;
  Future<void> showProfile() async {
    try {
      emit(ProfileLoading());
      ProfileRepo.showProfile().then((value) => value.fold(
              (failure) => emit(ProfileError(errorMessage: failure.message)),
              (response) {
            emit(ProfileSuccess());
          }));
    } catch (_) {
      {}
    }
  }

  Future<void> updateProfile(
      {required String name,
      required String address,
      required String phone}) async {
    try {
      emit(ProfileLoading());
      ProfileRepo.updateProfile(name: name, address: address, phone: phone)
          .then((value) => value.fold(
                  (failure) =>
                      emit(ProfileError(errorMessage: failure.message)),
                  (response) {
                SharedPrefs.setUserInfo(response);
                emit(ProfileUpdateSuccess());
              }));
    } catch (_) {}
  }

  Future<void> updatePassword() async {
    try {
      emit(ProfileLoading());
      ProfileRepo.updatePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        newPasswordConfirmation: newPasswordConfirmationController.text,
      ).then((value) => value.fold(
          (failure) => emit(ProfileError(errorMessage: failure.message)),
          (response) => emit(ProfileSuccess())));
    } catch (_) {}
  }

  Future<void> logout() async {
    try {
      emit(ProfileLoading());
      ProfileRepo.logout().then((value) => value.fold(
              (failure) => emit(ProfileError(errorMessage: failure.message)),
              (response) {
            SharedPrefs.removeUserData();
            emit(ProfileSuccess());
          }));
    } catch (_) {}
  }

  void changeTheme({required ThemeMode themeMode}) async {
    this.themeMode = themeMode;
    SharedPrefs.setTheme(themeMode: themeMode);
    emit(ThemeState(themeMode: themeMode));
  }
}
