import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/buttons/main_text_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/snack_bars/error_snack_bar.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/extensions/validation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        context.pushToBase(AppRouter.mainScreen);
                      }
                      if (state is AuthError) {
                        context.pop();
                        showErrorSnackBar(context, state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      var cubit = context.read<AuthCubit>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.width * 0.78,
                            child: Text('Welcome back! Glad to see you, Again!',
                                style: TextStyles.getHeadLine1()),
                          ),
                          Gap(32),
                          MainTextFormField(
                            controller: cubit.emailController,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'Please enter your email'
                                  : !value.isValidEmail()
                                      ? 'The email must be a valid email address.'
                                      : null;
                            },
                            text: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' ')
                            ],
                          ),
                          Gap(16),
                          MainTextFormField(
                            controller: cubit.passwordController,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'Please enter your password'
                                  : null;
                            },
                            text: 'Enter your password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                                onPressed: () {
                                  context.pushTo(AppRouter.forgotPassword);
                                },
                                child: Text(
                                  ' Forgot Password?',
                                  style: TextStyles.getSmall(
                                      fontSize: 15,
                                      color: AppColors.primaryColor),
                                )),
                          ),
                          Gap(62),
                          MainButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.login();
                                }
                              },
                              text: 'Login'),
                          Gap(34),
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: AppColors.grayColor,
                              )),
                              Gap(16),
                              Text(
                                'Or Login with',
                                style: TextStyles.getSmall(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.darkGrayColor
                                        : null),
                              ),
                              Gap(16),
                              Expanded(
                                  child: Divider(
                                color: AppColors.grayColor,
                              ))
                            ],
                          ),
                          Gap(21),
                          SocialLogin(),
                        ],
                      );
                    },
                  ),
                ),
              )),
          bottomNavigationBar: MainTextButton(
            text: 'Don’t have an account? ',
            clickableText: 'Register Now',
            onTap: () {
              context.pushToReplace(AppRouter.register);
            },
          )),
    );
  }
}
