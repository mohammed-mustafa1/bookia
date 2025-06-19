import 'package:bookia/components/back_icon_button.dart';
import 'package:bookia/components/main_button.dart';
import 'package:bookia/components/main_text_button.dart';
import 'package:bookia/components/main_text_form_field.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: BackIconButton(
            onPressed: () => context.pop(),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.width * 0.74,
                      child: Text('Hello! Register to get started',
                          style: TextStyles.getHeadLine1()),
                    ),
                    Gap(32),
                    MainTextFormField(text: 'Username'),
                    Gap(12),
                    MainTextFormField(text: 'Email'),
                    Gap(12),
                    MainTextFormField(text: 'Password'),
                    Gap(12),
                    MainTextFormField(text: 'Confirm password'),
                    Gap(30),
                    MainButton(onTap: () {}, text: 'Register'),
                  ],
                ),
              ),
            )),
        bottomNavigationBar: MainTextButton(
          text: 'Already have an account? ',
          clickableText: 'Login Now',
          onTap: () {
            context.pushTo(AppRouter.login);
          },
        ));
  }
}
