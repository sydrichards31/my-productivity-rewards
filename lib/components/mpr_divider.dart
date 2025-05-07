import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRDivider extends StatelessWidget {
  final bool light;
  const MPRDivider({
    super.key,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: light ? Colors.white : ColorPalette.gunmetal.shade100,
      thickness: 1,
      height: 1,
    );
  }
}
