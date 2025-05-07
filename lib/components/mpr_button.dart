import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRButton extends StatelessWidget {
  final MPRButtonStyle rkButtonStyle;
  final String text;
  final bool hasHorizontalPadding;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final double height;
  final bool hasBorder;
  final Color borderColor;
  final bool greyFont;

  const MPRButton._({
    super.key,
    required this.rkButtonStyle,
    required this.text,
    required this.onPressed,
    required this.hasHorizontalPadding,
    this.textStyle,
    this.height = 45,
    this.hasBorder = false,
    this.borderColor = Colors.white,
    this.greyFont = false,
  });

  factory MPRButton.primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool? hasHorizontalPadding,
    double height = 45,
  }) =>
      MPRButton._(
        key: key,
        rkButtonStyle: MPRButtonStyle.primary,
        text: text,
        hasHorizontalPadding: hasHorizontalPadding ?? false,
        onPressed: onPressed,
        textStyle: MPRTextStyles.regularBold.copyWith(
          color: onPressed == null
              ? ColorPalette.gunmetal.shade400
              : ColorPalette.white,
        ),
        height: height,
      );

  factory MPRButton.secondary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool? hasHorizontalPadding,
    Color? textColor = ColorPalette.gunmetal,
    double height = 45,
    Color? borderColor,
  }) =>
      MPRButton._(
        key: key,
        rkButtonStyle: MPRButtonStyle.secondary,
        text: text,
        hasHorizontalPadding: hasHorizontalPadding ?? true,
        onPressed: onPressed,
        textStyle: MPRTextStyles.regularBold.copyWith(
          color: textColor,
        ),
        hasBorder: true,
        height: height,
        borderColor: borderColor ?? Colors.white,
      );

  factory MPRButton.tertiaryCompact({
    Key? key,
    required String text,
    TextStyle? style,
    required VoidCallback? onPressed,
    bool useSemiBoldFont = false,
    bool smallFont = false,
    bool greyFont = false,
  }) =>
      MPRButton._(
        key: key,
        rkButtonStyle: MPRButtonStyle.tertiaryCompact,
        text: text,
        hasHorizontalPadding: false,
        onPressed: onPressed,
        greyFont: greyFont,
        textStyle: style ??
            (useSemiBoldFont
                ? (smallFont
                    ? MPRTextStyles.small10SemiBold
                    : MPRTextStyles.regularSemiBold)
                : MPRTextStyles.regularSemiBold),
      );

  @override
  Widget build(BuildContext context) {
    switch (rkButtonStyle) {
      case MPRButtonStyle.tertiaryCompact:
        return _TertiaryCompactButton(
          text: text,
          onPressed: onPressed,
          textStyle: textStyle!,
          greyFont: greyFont,
        );
      default:
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: hasHorizontalPadding ? 16.0 : 0.0,
          ),
          child: MaterialButton(
            height: height,
            color: rkButtonStyle == MPRButtonStyle.secondary
                ? Colors.white
                : ColorPalette.green,
            disabledColor: ColorPalette.gunmetal.shade100,
            shape: RoundedRectangleBorder(
              side: hasBorder
                  ? BorderSide(
                      color: onPressed != null ? borderColor : Colors.white,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(4.0),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
    }
  }
}

class _TertiaryCompactButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle textStyle;
  final bool greyFont;

  const _TertiaryCompactButton({
    required this.text,
    this.onPressed,
    required this.textStyle,
    this.greyFont = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary =
        greyFont ? ColorPalette.gunmetal.shade400 : ColorPalette.green;
    final style = TextButton.styleFrom(
      foregroundColor:
          onPressed != null ? primary : primary.withValues(alpha: 0.5),
      textStyle: onPressed != null
          ? textStyle
          : MPRTextStyles.regularSemiBold.copyWith(color: primary),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: Text(text),
    );
  }
}

enum MPRButtonStyle {
  primary,
  secondary,
  tertiaryCompact,
  square,
  circle,
  outlined,
  iconLeft,
  callButton,
}
