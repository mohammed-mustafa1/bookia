import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;
  List<Widget> screens = [
    Center(child: Text('Home')),
    Center(child: Text('Bookmark')),
    Center(child: Text('Cart')),
    Center(child: Text('Profile')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          Image.asset(AppAssets.appIconImage, width: 30),
          Gap(3),
          Text('Bookia',
              style: TextStyles.getTitle(
                  fontSize: 22,
                  color: context.brightness == Brightness.light
                      ? AppColors.darkColor
                      : AppColors.whiteColor))
        ]),
        actions: [
          SvgPicture.asset(
            AppAssets.searchSvg,
            colorFilter: ColorFilter.mode(
                context.brightness == Brightness.light
                    ? AppColors.darkColor
                    : AppColors.whiteColor,
                BlendMode.srcIn),
          ),
          Gap(12)
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.whiteColor,
        onTap: (value) => setState(() => currentIndex = value),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: SvgPicture.asset(
              AppAssets.homeSvg,
              colorFilter: ColorFilter.mode(
                  context.brightness == Brightness.light
                      ? AppColors.darkColor
                      : AppColors.whiteColor,
                  BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.homeSvg,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bookmark',
            icon: SvgPicture.asset(
              AppAssets.bookmarkSvg,
              colorFilter: ColorFilter.mode(
                  context.brightness == Brightness.light
                      ? AppColors.darkColor
                      : AppColors.whiteColor,
                  BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.bookmarkSvg,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: SvgPicture.asset(
              AppAssets.cartSvg,
              colorFilter: ColorFilter.mode(
                  context.brightness == Brightness.light
                      ? AppColors.darkColor
                      : AppColors.whiteColor,
                  BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.cartSvg,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.profileSvg,
              colorFilter: ColorFilter.mode(
                  context.brightness == Brightness.light
                      ? AppColors.darkColor
                      : AppColors.whiteColor,
                  BlendMode.srcIn),
            ),
            label: 'Profile',
            activeIcon: SvgPicture.asset(
              AppAssets.profileSvg,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
