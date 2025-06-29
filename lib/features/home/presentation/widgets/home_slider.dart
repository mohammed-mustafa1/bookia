import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/model/slider_response/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key, required this.sliders});
  final List<SliderModel> sliders;
  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20),
        CarouselSlider.builder(
          itemCount: widget.sliders.length,
          itemBuilder: (_, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.sliders[index].image ?? '',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.asset(AppAssets.noCoverImage, fit: BoxFit.cover);
                },
              ),
            );
          },
          options: CarouselOptions(
            aspectRatio: 4 / 1.8,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.25,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Gap(14),
        SmoothPageIndicator(
            controller:
                PageController(initialPage: activeIndex), // PageController
            count: widget.sliders.length,
            effect: ExpandingDotsEffect(
              dotHeight: 7,
              dotWidth: 7,
              spacing: 4,
              expansionFactor: 6,
              activeDotColor: AppColors.primaryColor,
              dotColor: Color(0xffD9D9D9),
            ),
            onDotClicked: (index) {})
      ],
    );
  }
}
