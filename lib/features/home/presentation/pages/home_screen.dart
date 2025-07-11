import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller_grid_view.dart';
import 'package:bookia/features/home/presentation/widgets/empty_home_ui.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
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
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            if (state is HomeError) {
              return Center(child: Text(state.message));
            } else if (state is HomeSuccess) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeSlider(sliders: cubit.sliders),
                    ),
                    Gap(32),
                    BestSellersSection(products: cubit.bestSellersList),
                    Gap(32),
                    AllProductsSection(products: cubit.allproducts)
                  ],
                ),
              );
            } else {
              return EmptyHomeUi();
            }
          },
        ),
      ),
    );
  }
}

class BestSellersSection extends StatelessWidget {
  const BestSellersSection({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Best Sellers', style: TextStyles.getHeadLine2()),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: BestSellerGridView(products: products),
        ),
      ],
    );
  }
}

class AllProductsSection extends StatelessWidget {
  const AllProductsSection({
    super.key,
    required this.products,
  });

  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('All Products', style: TextStyles.getHeadLine2()),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: BestSellerGridView(products: products),
        ),
      ],
    );
  }
}
