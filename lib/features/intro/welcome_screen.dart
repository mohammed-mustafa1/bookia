import 'package:bookia/components/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.welcomeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Gap(context.height * 0.16),
              SvgPicture.asset(AppAssets.logoImageSvg),
              Gap(28),
              Text('Order Your Book Now!',
                  style: TextStyles.getTitle(
                      fontSize: 20, color: AppColors.darkColor)),
              Spacer(),
              MainButton(
                  text: 'Login',
                  onTap: () {
                    context.pushTo(AppRouter.login);
                  }),
              Gap(15),
              MainButton(
                text: 'Register',
                textColor: Colors.black,
                backgroundColor: AppColors.whiteColor,
                borderColor: AppColors.darkColor,
                onTap: () {
                  context.pushTo(AppRouter.register);
                },
              ),
              Gap(context.height * 0.11),
            ],
          ),
        ),
      ),
    );
  }
}
