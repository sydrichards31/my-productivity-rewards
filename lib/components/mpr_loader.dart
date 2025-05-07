import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRLoader extends StatelessWidget {
  final MPRProgressIndicatorStyle mobProgressIndicatorStyle;
  final Color? trackColor;
  final double? value;

  const MPRLoader._({
    super.key,
    required this.mobProgressIndicatorStyle,
    required this.trackColor,
    this.value,
  });

  factory MPRLoader.circular({
    Key? key,
    double? value,
  }) =>
      MPRLoader._(
        key: key,
        mobProgressIndicatorStyle: MPRProgressIndicatorStyle.circular,
        trackColor: null,
        value: value,
      );

  factory MPRLoader.linear({
    Key? key,
    double? value,
  }) =>
      MPRLoader._(
        key: key,
        mobProgressIndicatorStyle: MPRProgressIndicatorStyle.linear,
        trackColor: ColorPalette.gunmetal.shade100,
        value: value,
      );

  @override
  Widget build(BuildContext context) {
    switch (mobProgressIndicatorStyle) {
      case MPRProgressIndicatorStyle.circular:
        return CircularProgressIndicator(
          value: value,
          color: ColorPalette.green,
        );
      case MPRProgressIndicatorStyle.linear:
        return LinearProgressIndicator(
          value: value,
          color: ColorPalette.green.withValues(alpha: 0.8),
          backgroundColor: trackColor,
        );
    }
  }
}

enum MPRProgressIndicatorStyle {
  circular,
  linear,
}
