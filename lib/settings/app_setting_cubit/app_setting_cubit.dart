import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cache/cache_helper.dart';
import '../cache/cache_helper_keys.dart';
import 'app_setting_states.dart';

enum LanguageEnum { arabic, english, system }

enum ThemeEnum { dark, light, system }

class AppSettingCubit extends Cubit<AppSettingStates> {
  AppSettingCubit({String? savedTheme, String? savedLanguage})
    : super(SelectedThemeInitial()) {
    // نستخدم نفس دوال التحميل لكن بمفتاح محفوظ
    _loadThemeByKey(savedTheme);
    _loadLanguageByKey(savedLanguage);
    emit(SelectedThemeSuccess());
  }
  //lambada function to create Bloc Provider from this cubit
  static AppSettingCubit get(context) => BlocProvider.of(context);

  //language variables
  static LanguageEnum currentLanguage = LanguageEnum.system;
  var systemLanguage = PlatformDispatcher.instance.locale.languageCode;

  //theme variables
  static ThemeMode currentTheme = ThemeMode.system;

  //1. select language
  Future<void> selectedLanguage({required LanguageEnum language}) async {
    currentLanguage = language;
    await CacheHelper().saveData(
      key: CacheHelperKeys.keyLanguage,
      value: currentLanguage.name,
    );
    emit(SelectedLanguageSuccess());
  }

  //2. get language
  String getLanguage() {
    String selectedLanguage = systemLanguage;
    switch (currentLanguage) {
      case LanguageEnum.arabic:
        selectedLanguage = 'ar';
        break;
      case LanguageEnum.english:
        selectedLanguage = 'en';
        break;
      case LanguageEnum.system:
        selectedLanguage = systemLanguage;
        break;
    }
    return selectedLanguage;
  }

  //3. load language
  void _loadLanguageByKey(String? language) {
    String? savedLanguage = language;
    currentLanguage = LanguageEnum.values.firstWhere(
      (element) {
        return element.name == savedLanguage;
      },
      orElse: () {
        return LanguageEnum.system;
      },
    );
  }

  //1. select theme
  Future<void> selectedTheme({required ThemeMode theme}) async {
    currentTheme = theme;
    await CacheHelper().saveTheme(
      key: CacheHelperKeys.keyThemeMode,
      value: currentTheme.name, // بيروح String
    );
    emit(SelectedThemeSuccess());
  }

  //2. get theme
  ThemeMode getTheme() {
    switch (currentTheme) {
      case ThemeMode.dark:
        return ThemeMode.dark;
      case ThemeMode.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  //3. get Dark For controller
  bool isDarkModeEnabled() {
    return getTheme() == ThemeMode.dark;
  }

  //4. load theme
  void _loadThemeByKey(String? theme) {
    String? savedTheme = theme;
    if (savedTheme != null) {
      currentTheme = ThemeMode.values.firstWhere(
        (element) {
          return element.name == savedTheme;
        },
        orElse: () {
          return ThemeMode.system;
        },
      );
    }
    emit(SelectedThemeSuccess());
  }
}
