import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? trailingActions;

  const MPRAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailingActions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          title: Text(
            title,
            style: MPRTextStyles.appHeader.copyWith(color: Colors.white),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: ColorPalette.green,
          leading: leading,
          actions: trailingActions,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
