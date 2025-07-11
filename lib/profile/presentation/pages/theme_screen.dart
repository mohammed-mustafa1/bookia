import 'package:bookia/components/buttons/back_icon_button.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:bookia/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:bookia/profile/presentation/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackIconButton(onPressed: () => context.pop()),
            Spacer(flex: 2),
            Text('Theme'),
            Spacer(flex: 3),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();
            return Column(
              spacing: 16,
              children: [
                ProfileItem(
                  text: 'System',
                  trailing: Radio(
                    value: ThemeMode.system,
                    groupValue: cubit.themeMode,
                    onChanged: (value) {
                      cubit.changeTheme(themeMode: value!);
                    },
                  ),
                ),
                ProfileItem(
                  text: 'Light',
                  trailing: Radio(
                    value: ThemeMode.light,
                    groupValue: cubit.themeMode,
                    onChanged: (value) {
                      cubit.changeTheme(themeMode: value!);
                    },
                  ),
                ),
                ProfileItem(
                  text: 'Dark',
                  trailing: Radio(
                    value: ThemeMode.dark,
                    groupValue: cubit.themeMode,
                    onChanged: (value) {
                      cubit.changeTheme(themeMode: value!);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
