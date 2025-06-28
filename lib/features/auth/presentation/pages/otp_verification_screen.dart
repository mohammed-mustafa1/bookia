import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/buttons/main_text_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/extensions/navigation.dart';
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
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, this.email});
  final String? email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? pin;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showLoadingDialog(context);
          } else if (state is AuthSuccess && pin != null) {
            context.pop();
            context.pushToReplace(AppRouter.createNewPassword, extra: pin);
          } else if (state is AuthSuccess && pin == null) {
            context.pop();
          } else if (state is AuthError) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ));
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();

          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: BackIconButton(onPressed: () => context.pop())),
            body: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: formKey,
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
                        controller: cubit.otpController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        length: 6,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        forceErrorState: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        submittedPinTheme: PinTheme(
                          width: 70,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.darkColor
                                  : AppColors.accentColor,
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          textStyle: TextStyles.getHeadLine1(fontSize: 22),
                        ),
                        defaultPinTheme: PinTheme(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.darkColor
                                  : AppColors.accentColor,
                              border: Border.all(color: AppColors.borderColor)),
                          textStyle: TextStyles.getHeadLine1(fontSize: 22),
                          width: 70,
                          height: 60,
                          constraints:
                              BoxConstraints(maxHeight: 60, maxWidth: 70),
                        ),
                        closeKeyboardWhenCompleted: true,
                        enabled: true,
                      ),
                      Gap(36),
                      MainButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.emailController.text = widget.email!;
                              pin = cubit.otpController.text;
                              cubit.otpVerification();
                            }
                            // context.pushTo(AppRouter.createNewPassword);
                          },
                          text: 'Verify'),
                    ],
                  )),
                )),
            bottomNavigationBar: MainTextButton(
              text: 'Didn’t received code?',
              clickableText: 'Resend',
              onTap: () {
                cubit.emailController.text = widget.email!;
                cubit.forgotPassword();
              },
            ),
          );
        },
      ),
    );
  }
}
