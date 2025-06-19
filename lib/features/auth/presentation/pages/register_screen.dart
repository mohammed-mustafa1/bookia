import 'package:bookia/components/back_icon_button.dart';
import 'package:bookia/components/main_button.dart';
import 'package:bookia/components/main_text_form_field.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
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
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyles.getSmall(fontSize: 15),
          ),
          TextButton(
            onPressed: () {
              context.pushTo(AppRouter.login);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Text(' Login Now',
                style: TextStyles.getSmall(
                    fontSize: 15, color: AppColors.primaryColor)),
          ),
        ],
      ),
    );
  }
}
