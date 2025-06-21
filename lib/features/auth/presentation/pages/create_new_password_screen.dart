import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key, required this.pinCode});
  final String? pinCode;

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: BackIconButton(onPressed: () => context.pop())),
        body: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      showLoadingDialog(context);
                    }
                    if (state is AuthSuccess) {
                      context.pop();
                      context.pushReplacement(AppRouter.passwordChanged);
                    }
                    if (state is AuthError) {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.errorMessage),
                      ));
                    }
                  },
                  builder: (context, state) {
                    var cubit = context.read<AuthCubit>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: context.width * 0.74,
                          child: Text('Create new password',
                              style: TextStyles.getHeadLine1()),
                        ),
                        Gap(10),
                        Text(
                          "Your new password must be unique from those previously used.",
                          style: TextStyles.getBody(color: AppColors.grayColor),
                        ),
                        Gap(32),
                        MainTextFormField(
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          controller: cubit.passwordController,
                          text: 'New Password',
                          textInputAction: TextInputAction.next,
                        ),
                        Gap(16),
                        MainTextFormField(
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Password must be at least 8 characters';
                            } else if (value != cubit.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          controller: cubit.passwordConfirmationController,
                          text: 'Confirm Password',
                          textInputAction: TextInputAction.next,
                        ),
                        Gap(38),
                        MainButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.otpController.text = widget.pinCode!;
                                cubit.createNewPassword();
                              }
                            },
                            text: 'Reset Password'),
                      ],
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
