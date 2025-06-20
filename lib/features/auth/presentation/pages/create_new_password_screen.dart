import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
                    child: Text('Create new password',
                        style: TextStyles.getHeadLine1()),
                  ),
                  Gap(10),
                  Text(
                    "Your new password must be unique from those previously used.",
                    style: TextStyles.getBody(color: AppColors.grayColor),
                  ),
                  Gap(32),
                  MainTextFormField(text: 'New Password'),
                  Gap(16),
                  MainTextFormField(text: 'Confirm Password'),
                  Gap(38),
                  MainButton(
                      onTap: () {
                        context.pushReplacement(AppRouter.passwordChanged);
                      },
                      text: 'Reset Password'),
                ],
              ),
            ),
          )),
    );
  }
}

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.successMarIkImageSvg),
            Gap(35),
            Text('Password Changed!',
                style: TextStyles.getHeadLine1(fontSize: 26)),
            Gap(3),
            Text('Your password has been changed \n successfully.',
                textAlign: TextAlign.center,
                style: TextStyles.getBody(
                    fontSize: 15, color: AppColors.grayColor)),
            Gap(40),
            MainButton(
                onTap: () {
                  context.pushReplacement(AppRouter.login);
                },
                text: 'Back to Login')
          ],
        ),
      ),
    );
  }
}
