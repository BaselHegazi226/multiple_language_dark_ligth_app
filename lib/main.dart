import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/app_setting_cubit/app_setting_cubit.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/app_setting_cubit/app_setting_states.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/cache/cache_helper.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/cache/cache_helper_keys.dart';

import 'app_widgets/setting_app.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  final savedTheme = await CacheHelper().getData(
    key: CacheHelperKeys.keyThemeMode,
  );
  final savedLanguage = await CacheHelper().getData(
    key: CacheHelperKeys.keyLanguage,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>
          MyApp(savedTheme: savedTheme, savedLanguage: savedLanguage),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? savedTheme;
  final String? savedLanguage;

  const MyApp({super.key, this.savedTheme, this.savedLanguage});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppSettingCubit(savedTheme: savedTheme, savedLanguage: savedLanguage),
      child: BlocBuilder<AppSettingCubit, AppSettingStates>(
        builder: (context, state) {
          final appSettingCubit = AppSettingCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(appSettingCubit.getLanguage()),
            themeMode: appSettingCubit.getTheme(),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(fontSize: 24),
                color: Colors.blueAccent,
              ),
              dropdownMenuTheme: DropdownMenuThemeData(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.grey.shade900,
              appBarTheme: AppBarTheme(
                color: Colors.grey.shade700,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
              ),
              textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
              dropdownMenuTheme: DropdownMenuThemeData(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            home: SettingApp(
              savedLanguage: savedLanguage,
              savedTheme: savedTheme,
            ),
          );
        },
      ),
    );
  }
}
