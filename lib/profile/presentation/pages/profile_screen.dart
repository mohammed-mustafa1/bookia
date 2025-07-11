import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:bookia/profile/presentation/widgets/profile_details_section.dart';
import 'package:bookia/profile/presentation/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..showProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text('Profile'),
              actions: [
                GestureDetector(
                  onTap: () async {
                    showLoadingDialog(context);
                    await cubit.logout();
                    context.pushToBase(AppRouter.welcome);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset(
                      AppAssets.exitSvg,
                      colorFilter: ColorFilter.mode(
                        context.brightness == Brightness.light
                            ? AppColors.darkColor
                            : AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 16,
                children: [
                  ProfileDetailsSection(
                    user: SharedPrefs.getUserInfo() ?? User(),
                  ),
                  Gap(4),
                  ProfileItem(text: 'My Orders', onTap: () {}),
                  ProfileItem(
                      text: 'Edit Profile',
                      onTap: () {
                        context.pushTo(AppRouter.editProfile).then((_) {
                          setState(() {});
                        });
                      }),
                  ProfileItem(
                      text: 'Reset Password',
                      onTap: () {
                        context.pushTo(AppRouter.resetPassword);
                      }),
                  ProfileItem(
                      text: 'Theme Mode',
                      onTap: () {
                        context.push(AppRouter.changeTheme);
                      }),
                  ProfileItem(text: 'FAQ', onTap: () {}),
                  ProfileItem(text: 'Contact Us', onTap: () {}),
                  ProfileItem(text: 'Privacy & Terms', onTap: () {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
