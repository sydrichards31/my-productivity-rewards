import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class MPRDropdown extends StatelessWidget {
  final String? value;
  final List<String> values;
  final ValueChanged<String?> onValueChanged;
  final VoidCallback? onTap;
  final String? label;
  final String? hint;
  final bool isError;

  const MPRDropdown({
    super.key,
    required this.value,
    required this.values,
    required this.onValueChanged,
    this.onTap,
    this.label,
    this.hint,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final greyOutlineBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalette.platinum.shade600,
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                labelStyle: MPRTextStyles.headline3
                    .copyWith(color: ColorPalette.gunmetal.shade300),
                hintStyle: MPRTextStyles.headline3,
                border: greyOutlineBorder,
                enabledBorder: greyOutlineBorder,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 24,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: hint != null
                      ? Text(
                          hint!,
                          style: MPRTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorPalette.gunmetal.shade300,
                          ),
                        )
                      : null,
                  value: value,
                  onChanged: onValueChanged,
                  onTap: onTap,
                  items: values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: MPRTextStyles.regular,
                          ),
                        ),
                      )
                      .toList(),
                  icon: _DropdownIcon(isError: isError),
                  style: MPRTextStyles.headline3,
                  isDense: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DropdownIcon extends StatelessWidget {
  final bool isError;
  const _DropdownIcon({
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const Icon(
        Icons.refresh,
        color: ColorPalette.red,
      );
    } else {
      return SvgAdapter.asset(
        context.read<AppTheme>().images.chevronDown,
        color: ColorPalette.gunmetal.shade700,
        height: 16,
        width: 16,
      );
    }
  }
}
