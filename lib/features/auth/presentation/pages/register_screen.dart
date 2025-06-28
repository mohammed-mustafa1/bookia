import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/buttons/main_text_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/extensions/validation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: BackIconButton(onPressed: () => context.pop()),
          ),
          body: Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: SingleChildScrollView(
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        showLoadingDialog(context);
                      }
                      if (state is AuthSuccess) {
                        context.pop();
                        context.pushToReplace(AppRouter.login);
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
                            child: Text('Hello! Register to get started',
                                style: TextStyles.getHeadLine1()),
                          ),
                          Gap(32),
                          MainTextFormField(
                            text: 'Username',
                            controller: cubit.nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'Please enter your username'
                                  : null;
                            },
                          ),
                          Gap(16),
                          MainTextFormField(
                            text: 'Email',
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                            validator: (vlaue) {
                              return vlaue == null || vlaue.isEmpty
                                  ? 'Please enter your email'
                                  : !vlaue.isValidEmail()
                                      ? 'The email must be a valid email address.'
                                      : null;
                            },
                          ),
                          Gap(16),
                          MainTextFormField(
                            textInputAction: TextInputAction.next,
                            controller: cubit.passwordController,
                            text: 'Password',
                            obscureText: true,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'Please enter your password'
                                  : value.length < 8
                                      ? ' The password must be at least 8 characters.'
                                      : null;
                            },
                          ),
                          Gap(16),
                          MainTextFormField(
                              controller: cubit.passwordConfirmationController,
                              text: 'Confirm password',
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 8) {
                                  return ' The password must be at least 8 characters.';
                                }
                                if (value != cubit.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              }),
                          Gap(32),
                          MainButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.register();
                                }
                              },
                              text: 'Register'),
                        ],
                      );
                    },
                  ),
                ),
              )),
          bottomNavigationBar: MainTextButton(
            text: 'Already have an account? ',
            clickableText: 'Login Now',
            onTap: () {
              context.pushToReplace(AppRouter.login);
            },
          )),
    );
  }
}
