import 'package:flutter/material.dart';
import 'package:my_productive_rewards/utils/svg_adapter.dart';

class MPRAppBarAction extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final double? size;
  final bool png;
  const MPRAppBarAction({
    super.key,
    required this.iconPath,
    required this.onPressed,
    this.size,
    this.png = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: png
          ? Image.asset(
              iconPath,
              width: size ?? 22,
              height: size ?? 22,
            )
          : SvgAdapter.asset(
              iconPath,
              height: size ?? 22,
              width: size ?? 22,
              color: Colors.white,
            ),
    );
  }
}
