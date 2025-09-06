import 'package:flutter/material.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/app_widgets/language_drop_down_button.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/app_widgets/theme_item.dart';

import '../generated/l10n.dart';

class SettingApp extends StatelessWidget {
  const SettingApp({
    super.key,
    required this.savedTheme,
    required this.savedLanguage,
  });
  final String? savedTheme;
  final String? savedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).FlutterLocalization),
        actions: [const ThemeItem()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              S.current.Hello,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            LanguageDropDownButton(lastLanguage: savedLanguage),
          ],
        ),
      ),
    );
  }
}
