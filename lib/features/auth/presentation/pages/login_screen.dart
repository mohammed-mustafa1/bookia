import 'package:bookia/components/back_icon_button.dart';
import 'package:bookia/components/main_button.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/components/main_text_form_field.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    child: Text('Welcome back! Glad to see you, Again!',
                        style: TextStyles.getHeadLine1()),
                  ),
                  Gap(32),
                  MainTextFormField(text: 'Enter your email'),
                  Gap(15),
                  MainTextFormField(
                      text: 'Enter your password', obscureText: true),
                  Gap(62),
                  MainButton(onTap: () {}, text: 'Login'),
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
                            color:
                                Theme.of(context).brightness == Brightness.light
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
              ),
            ),
          )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don’t have an account?',
            style: TextStyles.getSmall(fontSize: 15),
          ),
          TextButton(
            onPressed: () {
              context.pushTo(AppRouter.register);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Text(' Register Now',
                style: TextStyles.getSmall(
                    fontSize: 15, color: AppColors.primaryColor)),
          ),
        ],
      ),
    );
  }
}
