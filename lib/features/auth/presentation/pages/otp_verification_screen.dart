import 'package:bookia/components/back_icon_button.dart';
import 'package:bookia/components/main_button.dart';
import 'package:bookia/components/main_text_button.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
                    child: Text('OTP Verification',
                        style: TextStyles.getHeadLine1()),
                  ),
                  Gap(10),
                  Text(
                    "Enter the verification code we just sent on your email address.",
                    style: TextStyles.getBody(color: AppColors.grayColor),
                  ),
                  Gap(32),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 4,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    submittedPinTheme: PinTheme(
                      width: 70,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.primaryColor)),
                      textStyle: TextStyles.getHeadLine1(fontSize: 22),
                    ),
                    defaultPinTheme: PinTheme(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.borderColor)),
                      textStyle: TextStyles.getHeadLine1(fontSize: 22),
                      width: 70,
                      height: 60,
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 70),
                    ),
                    closeKeyboardWhenCompleted: true,
                    enabled: true,
                  ),
                  Gap(36),
                  MainButton(
                      onTap: () {
                        context.pushTo(AppRouter.createNewPassword);
                      },
                      text: 'Verify'),
                ],
              ),
            ),
          )),
      bottomNavigationBar: MainTextButton(
        text: 'Didn’t received code?',
        clickableText: 'Resend',
        onTap: () {
          context.pop();
        },
      ),
    );
  }
}
