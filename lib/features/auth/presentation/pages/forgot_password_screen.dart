import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/buttons/main_text_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/extensions/validation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email;
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
              autovalidateMode: AutovalidateMode.onUnfocus,
              key: formKey,
              child: SingleChildScrollView(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      showLoadingDialog(context);
                    }
                    if (state is AuthSuccess) {
                      context.pop();
                      context.pushToReplace(AppRouter.otpVerification,
                          extra: email);
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
                          child: Text('Forgot Password?',
                              style: TextStyles.getHeadLine1()),
                        ),
                        Gap(10),
                        Text(
                          "Don't worry! It occurs. Please enter the email address linked with your account.",
                          style: TextStyles.getBody(color: AppColors.grayColor),
                        ),
                        Gap(30),
                        MainTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.isValidEmail()) {
                              return 'The email must be a valid email address.';
                            }
                            return null;
                          },
                          controller: cubit.emailController,
                          text: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(' ')
                          ],
                        ),
                        Gap(38),
                        MainButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                email = cubit.emailController.text;
                                cubit.forgotPassword();
                                // context.pushTo(AppRouter.otpVerification);
                              }
                            },
                            text: 'Send Code'),
                      ],
                    );
                  },
                ),
              ),
            )),
        bottomNavigationBar: MainTextButton(
          text: 'Remember Password?',
          clickableText: 'Login',
          onTap: () {
            context.pushToReplace(AppRouter.login);
          },
        ),
      ),
    );
  }
}
