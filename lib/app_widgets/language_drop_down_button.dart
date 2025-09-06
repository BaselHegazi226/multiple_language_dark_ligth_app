import 'package:flutter/material.dart';
import 'package:multiple_language_and_theme_ligth_dark_app/settings/app_setting_cubit/app_setting_cubit.dart';

import 'custom_drop_down_item.dart';

class LanguageDropDownButton extends StatefulWidget {
  const LanguageDropDownButton({
    super.key,
    required this.lastTheme,
    required this.lastLanguage,
  });
  final dynamic lastLanguage;
  final dynamic lastTheme;
  static final List<String> _items = ['العربية', 'English'];

  @override
  State<LanguageDropDownButton> createState() => _LanguageDropDownButtonState();
}

class _LanguageDropDownButtonState extends State<LanguageDropDownButton> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = dropDownValueFun(language: widget.lastLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context); // 👈 هنستخدم الـ theme الحالي

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * .04),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.grey[850]
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        value: dropdownValue,
        isExpanded: true,
        icon: Padding(
          padding: dropdownValue == 'العربية'
              ? EdgeInsets.only(right: screenWidth < 350 ? 10 : 30)
              : EdgeInsets.only(left: screenWidth < 350 ? 10 : 30),
          child: Icon(
            Icons.keyboard_arrow_down,
            size: screenWidth < 350 ? 20 : 32,
            color: theme.iconTheme.color, // 👈 أيقونة حسب الثيم
          ),
        ),
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: screenWidth < 350 ? 12 : 16,
          fontWeight: FontWeight.w500,
        ), // 👈 النصوص حسب الثيم
        dropdownColor: theme.brightness == Brightness.dark
            ? Colors.grey[850]
            : Colors.white,
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              dropdownValue = value;
            });
            var language = getLanguage(language: dropdownValue);
            AppSettingCubit.get(context).selectedLanguage(language: language);
          }
        },
        items: LanguageDropDownButton._items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: CustomDrowDownItem(text: value, outside: false),
          );
        }).toList(),
        selectedItemBuilder: (context) {
          return LanguageDropDownButton._items.map((String value) {
            return CustomDrowDownItem(text: value);
          }).toList();
        },
      ),
    );
  }

  LanguageEnum getLanguage({required String language}) {
    switch (language) {
      case 'العربية':
        return LanguageEnum.arabic;
      case 'English':
        return LanguageEnum.english;
      default:
        return LanguageEnum.system;
    }
  }

  String dropDownValueFun({required String language}) {
    switch (language) {
      case 'english':
        return 'English';
      case 'arabic':
        return 'العربية';
      default:
        return 'English';
    }
  }
}
