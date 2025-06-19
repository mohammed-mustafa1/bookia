import 'package:bookia/components/back_icon_button.dart';
import 'package:bookia/components/main_button.dart';
import 'package:bookia/components/main_text_button.dart';
import 'package:bookia/components/main_text_form_field.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: BackIconButton(onPressed: () => context.pop())),
      body: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
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
                  MainTextFormField(text: 'Enter your email'),
                  Gap(38),
                  MainButton(
                      onTap: () {
                        context.pushTo(AppRouter.otpVerification);
                      },
                      text: 'Send Code'),
                ],
              ),
            ),
          )),
      bottomNavigationBar: MainTextButton(
        text: 'Remember Password?',
        clickableText: 'Login',
        onTap: () {
          context.pushToBase(AppRouter.login);
        },
      ),
    );
  }
}
