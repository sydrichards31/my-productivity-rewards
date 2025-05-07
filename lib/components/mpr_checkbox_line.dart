import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRCheckboxLine extends StatelessWidget {
  final bool value;
  final String text;
  final Function(bool?)? onChanged;
  final Widget? infoIcon;

  const MPRCheckboxLine({
    super.key,
    required this.value,
    required this.text,
    this.onChanged,
    this.infoIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: ColorPalette.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          side: BorderSide(color: ColorPalette.gunmetal.shade200),
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                text,
                style: MPRTextStyles.regular,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
              if (infoIcon != null) infoIcon!,
            ],
          ),
        ),
      ],
    );
  }
}
