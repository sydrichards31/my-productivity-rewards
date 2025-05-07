import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class AppTheme {
  final String appName;
  final Images images;
  final Fonts fonts;
  final ColorPalette colorPalette;
  final MPRTextStyles textStyles;
  final ThemeData? lightThemeData;
  final ThemeData? darkThemeData;

  const AppTheme({
    required this.appName,
    required this.images,
    required this.fonts,
    required this.colorPalette,
    required this.textStyles,
    this.lightThemeData,
    this.darkThemeData,
  });
}

class AppThemes {
  static final theme = AppTheme(
    appName: 'My Productivity Rewards',
    images: Images(),
    fonts: Fonts(),
    colorPalette: ColorPalette(),
    textStyles: MPRTextStyles(),
  );
}
