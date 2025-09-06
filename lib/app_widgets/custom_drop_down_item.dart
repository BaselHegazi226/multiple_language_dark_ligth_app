// custom_drop_down_item.dart
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class CustomDrowDownItem extends StatelessWidget {
  const CustomDrowDownItem({
    super.key,
    required this.text,
    this.outside = true,
  });

  final String text;
  final bool outside;

  @override
  Widget build(BuildContext context) {
    return outside
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backIcon(value: text),
              const SizedBox(width: 8),
              Text(text),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              const SizedBox(width: 8),
              backIcon(value: text),
            ],
          );
  }

  Widget backIcon({required String value}) {
    switch (value) {
      case 'Select your language' || 'اختار اللغه':
        return const SizedBox();
      case 'العربية':
        return const Iconify(Twemoji.flag_for_flag_egypt, size: 20);
      case 'English':
        return const Iconify(Twemoji.flag_for_flag_united_states, size: 20);
      default:
        return const SizedBox();
    }
  }
}
