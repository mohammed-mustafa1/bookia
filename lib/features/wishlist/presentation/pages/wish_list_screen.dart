import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wish_list_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListCubit()..getWishList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('WishList', style: TextStyles.getHeadLine2()),
          centerTitle: true,
        ),
        body: BlocBuilder<WishListCubit, WishListState>(
          builder: (context, state) {
            return ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Hero(
                  tag: index,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: '',
                        // product.image ?? '',
                        width: 100, height: 118,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            AppAssets.noCoverImage,
                            width: 100,
                            height: 118,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      const Gap(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text('',
                                        style: TextStyles.getTitle(
                                            color: Color(0xff606060)),
                                        maxLines: 2)),
                                SvgPicture.asset(AppAssets.closeSvg),
                              ],
                            ),
                            Gap(9),
                            Text('\$285', style: TextStyles.getBody()),
                            Gap(16),
                            MainButton(
                                height: 40, onTap: () {}, text: 'Add to Cart')
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider(
                  color: Color(0xfff0f0f0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
