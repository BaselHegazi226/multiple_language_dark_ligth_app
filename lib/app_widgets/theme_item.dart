import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/app_setting_cubit/app_setting_cubit.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/app_setting_cubit/app_setting_states.dart';

class ThemeItem extends StatelessWidget {
  const ThemeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingStates>(
      builder: (context, state) {
        final themeMode = AppSettingCubit.get(context).getTheme();
        final isDark = themeMode == ThemeMode.dark;

        return Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            onPressed: () {
              if (isDark) {
                AppSettingCubit.get(
                  context,
                ).selectedTheme(theme: ThemeMode.light);
              } else {
                AppSettingCubit.get(
                  context,
                ).selectedTheme(theme: ThemeMode.dark);
              }
            },
            icon: Icon(
              isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
