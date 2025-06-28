import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';

import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
                  context.pop();
                },
                text: 'Back to Login')
          ],
        ),
      ),
    );
  }
}
