import 'package:flutter/material.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError({required this.errorMessage});
}

class ProfileUpdateSuccess extends ProfileState {}

class ThemeState extends ProfileState {
  final ThemeMode themeMode;
  ThemeState({required this.themeMode});
}
