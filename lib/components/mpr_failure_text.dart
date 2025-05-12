import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRFailureText extends StatelessWidget {
  final String text;
  const MPRFailureText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        text,
        style: MPRTextStyles.regular.copyWith(color: ColorPalette.red),
      ),
    );
  }
}
