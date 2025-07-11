import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileDetailsSection extends StatelessWidget {
  const ProfileDetailsSection({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.image ?? '',
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.person);
            },
          ),
        ),
        Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name ?? 'Guest user', style: TextStyles.getTitle()),
              Text(user.email ?? 'No Email Address',
                  style: TextStyles.getSmall())
            ],
          ),
        )
      ],
    );
  }
}
