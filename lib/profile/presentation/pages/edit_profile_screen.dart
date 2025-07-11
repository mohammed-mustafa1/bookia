import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/main_text_form_field.dart';
import 'package:bookia/components/loading_ui.dart';
import 'package:bookia/components/snack_bars/main_snack_bar.dart';
import 'package:bookia/core/services/shared_prefs.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    user = SharedPrefs.getUserInfo();
    nameController.text = user?.name ?? 'Guest User';
    phoneController.text = user?.phone ?? '';
    addressController.text = user?.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackIconButton(
              onPressed: () => context.pop(),
            ),
            Spacer(),
            Text('Edit Profile'),
            Spacer(),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              context.pop();
              showMainSnackBar(context,
                  text: 'Profile updated successfully',
                  type: SnackBarType.success);
            }
            if (state is ProfileError) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorMessage),
              ));
            }
          },
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();
            if (state is ProfileLoading) {
              return LoadingUi();
            }
            return Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                  imageUrl: user?.image ?? '',
                                  errorWidget: (context, url, error) {
                                    return const Icon(
                                      Icons.person,
                                      size: 130,
                                    );
                                  }),
                            ),
                            Positioned(
                                bottom: 6,
                                right: 6,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.whiteColor,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.primaryColor,
                                    size: 28,
                                  ),
                                )),
                          ]),
                          Gap(22),
                          MainTextFormField(
                            text: 'Full Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            controller: nameController,
                          ),
                          Gap(16),
                          MainTextFormField(
                            text: 'Phone',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            controller: phoneController,
                          ),
                          Gap(16),
                          MainTextFormField(
                            text: 'Address',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            controller: addressController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MainButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateProfile(
                            name: nameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                          );
                        }
                      },
                      text: 'Update Profile'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
