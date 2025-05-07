import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

mixin MPRDatePickerMixin {
  Future<DateTime?> showMPRDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    final minDate = firstDate ?? DateTime(1900);
    final maxDate = lastDate ?? DateTime(2100);
    return showDatePicker(
      context: context,
      initialDate: !initialDate.isBefore(minDate) ? initialDate : minDate,
      firstDate: minDate,
      lastDate: maxDate,
      helpText: 'Select Date',
      cancelText: 'Cancel',
      confirmText: 'Ok',
      builder: (_, child) {
        return Theme(
          data: _getThemeDataFromContext(context),
          child: child!,
        );
      },
    );
  }

  ThemeData _getThemeDataFromContext(BuildContext context) {
    return ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.copyWith(
            headlineMedium:
                MPRTextStyles.regularSemiBold.copyWith(fontSize: 34),
            titleMedium: MPRTextStyles.regular,
            titleSmall: MPRTextStyles.regular,
            bodySmall: MPRTextStyles.regular,
            labelLarge:
                MPRTextStyles.regularBold.copyWith(color: ColorPalette.green),
            labelSmall: MPRTextStyles.regular,
            bodyLarge: MPRTextStyles.regular,
          ),
      hintColor: ColorPalette.gunmetal.shade300,
      colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: ColorPalette.green,
            onPrimary: Colors.white,
            surfaceContainerHigh: Colors.white,
            onSurface: ColorPalette.gunmetal,
            error: ColorPalette.red,
          ),
    );
  }
}
