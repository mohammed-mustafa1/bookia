import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/cart/presentation/pages/cart_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/wishlist/presentation/pages/wish_list_screen.dart';
import 'package:bookia/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    WishListScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
