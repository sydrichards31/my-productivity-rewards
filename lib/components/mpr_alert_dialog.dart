import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

enum DialogResults {
  success,
  error,
}

class MPRAlertDialog extends StatelessWidget {
  final _MPRAlertDialogStyle _rkAlertDialogStyle;
  final String? title;
  final String message;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget>? actions;
  final String? icon;
  final Widget? child;

  factory MPRAlertDialog({
    Key? key,
    String? title,
    required String message,
    EdgeInsets? contentPadding,
    List<Widget>? actions,
    String? icon,
  }) =>
      MPRAlertDialog._(
        _MPRAlertDialogStyle.defaultDialog,
        key: key,
        title: title,
        message: message,
        contentPadding: contentPadding,
        actions: actions,
        icon: icon,
      );

  factory MPRAlertDialog.customChild({
    Key? key,
    String? title,
    EdgeInsets? contentPadding,
    List<Widget>? actions,
    String? icon,
    required Widget child,
  }) =>
      MPRAlertDialog._(
        _MPRAlertDialogStyle.customChild,
        key: key,
        title: title,
        contentPadding: contentPadding,
        actions: actions,
        icon: icon,
        child: child,
      );

  const MPRAlertDialog._(
    this._rkAlertDialogStyle, {
    super.key,
    this.title,
    this.message = '',
    this.contentPadding,
    this.actions,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: (!icon.isNullOrEmpty || !title.isNullOrEmpty)
          ? Row(
              children: [
                if (!icon.isNullOrEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgAdapter.asset(icon!),
                  ),
                if (!title.isNullOrEmpty)
                  Flexible(
                    child: Text(
                      title!,
                      style: MPRTextStyles.headline3,
                    ),
                  ),
              ],
            )
          : null,
      content: _rkAlertDialogStyle == _MPRAlertDialogStyle.customChild
          ? child
          : SingleChildScrollView(
              child: Text(
                message,
                style: MPRTextStyles.regular,
              ),
            ),
      contentPadding: (!icon.isNullOrEmpty || !title.isNullOrEmpty)
          ? const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 18.0)
          : contentPadding ?? const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 18.0),
      actions: actions,
      actionsPadding: EdgeInsets.only(
        right: 10,
        bottom: 8,
      ),
    );
  }

  Future<T?> show<T>({
    required BuildContext context,
    bool barrierDismissible = true,
  }) async {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (_) => PopScope(
        canPop: barrierDismissible,
        child: this,
      ),
    );
  }
}

enum _MPRAlertDialogStyle {
  defaultDialog,
  customChild,
}
