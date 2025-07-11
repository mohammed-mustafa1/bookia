import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/components/snack_bars/main_snack_bar.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ResestPasswordScreen extends StatefulWidget {
  const ResestPasswordScreen({super.key});

  @override
  State<ResestPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<ResestPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            showLoadingDialog(context);
          }
          if (state is ProfileSuccess) {
            context.pop();
            showMainSnackBar(context,
                text: 'Password changed successfully',
                type: SnackBarType.success);
            context.pop();
          }
          if (state is ProfileError) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ));
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();

          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: BackIconButton(onPressed: () => context.pop())),
            body: Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text('New Password',
                              style: TextStyles.getHeadLine1())),
                      Gap(42),
                      MainTextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        controller: cubit.currentPasswordController,
                        text: 'Current Password',
                        textInputAction: TextInputAction.next,
                      ),
                      Gap(16),
                      MainTextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        controller: cubit.newPasswordController,
                        text: 'New Password',
                        textInputAction: TextInputAction.next,
                      ),
                      Gap(16),
                      MainTextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          } else if (value !=
                              cubit.newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        controller: cubit.newPasswordConfirmationController,
                        text: 'Confirm Password',
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(22),
              child: MainButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    cubit.updatePassword();
                  }
                },
                text: 'Update Password',
              ),
            ),
          );
        },
      ),
    );
  }
}
