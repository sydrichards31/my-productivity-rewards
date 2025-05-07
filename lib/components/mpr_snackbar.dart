import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRSnackBar extends SnackBar {
  final String text;
  final Key? actionOnPressedKey;
  final String? actionLabel;
  final VoidCallback? actionOnPressed;
  final SnackBarType type;

  MPRSnackBar({
    super.key,
    required this.text,
    this.actionOnPressedKey,
    this.actionLabel,
    this.actionOnPressed,
    this.type = SnackBarType.normal,
  }) : super(
          backgroundColor: type == SnackBarType.error
              ? ColorPalette.red.shade300
              : const Color(0xff323232),
          content: ExcludeSemantics(
            child: Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style:
                            MPRTextStyles.regular.copyWith(color: Colors.white),
                      ),
                    ),
                    if (actionLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          key: actionOnPressedKey,
                          onTap: () {
                            actionOnPressed?.call();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Text(
                            actionLabel,
                            style: MPRTextStyles.regularBold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          behavior: SnackBarBehavior.floating,
        );

  void show(
    BuildContext context, {
    bool hideCurrentSnackBar = true,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (hideCurrentSnackBar) {
      scaffoldMessenger.hideCurrentSnackBar();
    }
    scaffoldMessenger.showSnackBar(
      this,
    );
    SemanticsService.announce(text, TextDirection.ltr);
  }
}

enum SnackBarType {
  normal,
  error,
}
