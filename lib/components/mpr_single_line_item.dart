import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/svg_adapter.dart';

class MPRSingleLineItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? rightIcon;
  final double? rightIconPadding;
  final TextStyle? textStyleOverride;
  final String? _iconPath;
  final double _iconSize;
  final bool iconOnRight;
  final double horizontalPadding;
  final double verticalPadding;

  const MPRSingleLineItem({
    super.key,
    required this.text,
    required this.onPressed,
    this.rightIcon,
    this.rightIconPadding,
    this.textStyleOverride,
    this.iconOnRight = true,
    this.horizontalPadding = 20,
    this.verticalPadding = 15,
    String? iconPath,
    double iconSize = 24.0,
  })  : _iconPath = iconPath,
        _iconSize = iconSize;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.read<AppTheme>();
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_iconPath != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: _iconSize,
                      width: _iconSize,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgAdapter.asset(
                          _iconPath,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          text,
                          style: textStyleOverride ?? MPRTextStyles.regular,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (iconOnRight)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: SizedBox(
                      height: _iconSize,
                      width: _iconSize,
                      child: Padding(
                        padding: EdgeInsets.all(rightIconPadding ?? 5),
                        child: SvgAdapter.asset(
                          rightIcon ?? appTheme.images.rightArrow,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
