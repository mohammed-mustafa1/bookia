import 'package:bookia/core/extensions/theme.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EmptyHomeUi extends StatelessWidget {
  const EmptyHomeUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.brightness == Brightness.light
          ? Colors.grey.shade300
          : AppColors.darkColor,
      highlightColor: context.brightness == Brightness.light
          ? Colors.grey.shade100
          : AppColors.darkGrayColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Gap(20),
                  CarouselSlider.builder(
                    itemCount: 4,
                    itemBuilder: (_, index, realIndex) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                    options: CarouselOptions(
                        aspectRatio: 4 / 1.8,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.25,
                        scrollDirection: Axis.horizontal,
                        scrollPhysics: NeverScrollableScrollPhysics()),
                  ),
                  Gap(14),
                  SmoothPageIndicator(
                    controller:
                        PageController(initialPage: 0), // PageController
                    count: 4,
                    effect: ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      spacing: 4,
                      expansionFactor: 6,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: Color(0xffD9D9D9),
                    ),
                  )
                ],
              ),
            ),
            Gap(32),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Best Sellers', style: TextStyles.getHeadLine2())),
            Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.58,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ))
          ],
        ),
      ),
    );
  }
}
