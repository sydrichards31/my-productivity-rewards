import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_productive_rewards/themes/themes.dart';
import 'package:my_productive_rewards/utils/utils.dart';

class MPRTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onClear;
  final Icon? prefixIcon;
  final SuffixIconType? suffixIconType;
  final VoidCallback? suffixIconOnPressed;
  final Key? suffixIconKey;
  final int? maxLines;
  final int? maxLength;
  final bool isPassword;
  final bool isError;
  final bool autoCorrect;
  final bool isEnabled;
  final bool isButton;
  final Color? disabledFillColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final MPRTextFieldStyle textFieldStyle;
  final EdgeInsets? scrollPadding;
  final EdgeInsets? contentPadding;
  final TextAlign? textAlign;
  final Color? backgroundColor;
  final Color? suffixIconColor;
  final Color? textColor;
  final BoxConstraints? suffixIconConstraints;
  final bool autofocus;
  final bool fillColorEnabled;
  final bool hasBorder;
  final bool whiteFill;
  final bool expandSize;
  final double? height;
  final bool sameFocusedFill;
  final double? cornerRadius;

  factory MPRTextField.filled({
    Key? key,
    bool autoCorrect = true,
    String? label,
    String? hint,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    VoidCallback? onClear,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLines = 1,
    int? maxLength,
    SuffixIconType? suffixIconType,
    Key? suffixIconKey,
    bool isPassword = false,
    bool isError = false,
    bool isEnabled = true,
    EdgeInsets? contentPadding,
    Color? backgroundColor,
    Color? suffixIconColor,
    Color? textColor,
    List<TextInputFormatter>? inputFormatters,
    bool whiteFill = false,
    bool expandSize = false,
  }) =>
      MPRTextField._(
        key: key,
        autoCorrect: autoCorrect,
        label: label,
        hint: hint,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onClear: onClear,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        suffixIconType: suffixIconType,
        suffixIconKey: suffixIconKey,
        isPassword: isPassword,
        isError: isError,
        maxLines: maxLines,
        maxLength: maxLength,
        textFieldStyle: MPRTextFieldStyle.filled,
        isEnabled: isEnabled,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor,
        suffixIconColor: suffixIconColor,
        textColor: textColor,
        inputFormatters: inputFormatters,
        whiteFill: whiteFill,
        expandSize: expandSize,
      );

  factory MPRTextField.filledSmall({
    Key? key,
    bool autoCorrect = true,
    String? label,
    String? hint,
    required TextEditingController controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    VoidCallback? onClear,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLines = 1,
    int? maxLength,
    SuffixIconType? suffixIconType,
    VoidCallback? suffixIconOnPressed,
    Key? suffixIconKey,
    bool isPassword = false,
    bool isError = false,
    bool isEnabled = true,
    bool isButton = false,
    EdgeInsets? scrollPadding,
    bool whiteFill = false,
    bool expandSize = false,
    EdgeInsets? contentPadding,
  }) =>
      MPRTextField._(
        key: key,
        autoCorrect: autoCorrect,
        label: label,
        hint: hint,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onClear: onClear,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        suffixIconType: suffixIconType,
        suffixIconOnPressed: suffixIconOnPressed,
        suffixIconKey: suffixIconKey,
        isPassword: isPassword,
        isError: isError,
        maxLines: maxLines,
        maxLength: maxLength,
        textFieldStyle: MPRTextFieldStyle.filledSmall,
        isEnabled: isEnabled,
        isButton: isButton,
        scrollPadding: scrollPadding,
        whiteFill: whiteFill,
        expandSize: expandSize,
        disabledFillColor: ColorPalette.platinum.shade600,
        contentPadding: contentPadding,
      );

  factory MPRTextField.information({
    Key? key,
    String? header,
    required String description,
    String? hint,
    VoidCallback? onTap,
    int? maxLines = 1,
    SuffixIconType? suffixIconType,
    Key? suffixIconKey,
    bool isButton = false,
    bool isError = false,
    EdgeInsets? contentPadding,
  }) =>
      MPRTextField._(
        key: key,
        autoCorrect: false,
        label: header,
        controller: TextEditingController(
          text: description,
        ),
        hint: hint,
        onTap: onTap,
        suffixIconType: suffixIconType,
        suffixIconKey: suffixIconKey,
        maxLines: maxLines,
        textFieldStyle: MPRTextFieldStyle.information,
        isEnabled: false,
        isButton: isButton,
        isError: isError,
        contentPadding: contentPadding,
      );

  factory MPRTextField.outlinedCompact({
    Key? key,
    bool autoCorrect = false,
    String? label,
    String? hint,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    VoidCallback? onClear,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLength,
    int? maxLines = 1,
    Icon? prefixIcon,
    SuffixIconType? suffixIconType,
    Key? suffixIconKey,
    VoidCallback? suffixIconOnPressed,
    Color? suffixIconColor,
    bool isPassword = false,
    bool isError = false,
    bool isEnabled = true,
    FocusNode? focusNode,
    bool autofocus = false,
    Color? disabledFillColor,
    List<TextInputFormatter>? inputFormatters,
  }) =>
      MPRTextField._(
        key: key,
        autoCorrect: autoCorrect,
        label: label,
        hint: hint,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onClear: onClear,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        maxLines: maxLines,
        prefixIcon: prefixIcon,
        suffixIconType: suffixIconType,
        suffixIconKey: suffixIconKey,
        suffixIconOnPressed: suffixIconOnPressed,
        suffixIconColor: suffixIconColor,
        isPassword: isPassword,
        isError: isError,
        textFieldStyle: MPRTextFieldStyle.outlinedCompact,
        isEnabled: isEnabled,
        focusNode: focusNode,
        suffixIconConstraints: const BoxConstraints(),
        autofocus: autofocus,
        disabledFillColor: disabledFillColor,
        inputFormatters: inputFormatters,
      );

  factory MPRTextField.quantity({
    Key? key,
    String? hint,
    bool autoCorrect = true,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    VoidCallback? onClear,
    int? maxLength,
    int? maxLines = 1,
    bool isError = false,
    bool isEnabled = true,
    Color? disabledFillColor,
    TextAlign textAlign = TextAlign.start,
    bool fillColorEnabled = true,
    bool hasBorder = true,
  }) =>
      MPRTextField._(
        key: key,
        autoCorrect: autoCorrect,
        label: '',
        hint: hint,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onClear: onClear,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        maxLength: maxLength,
        maxLines: maxLines,
        isError: isError,
        isEnabled: isEnabled,
        textFieldStyle: MPRTextFieldStyle.quantity,
        disabledFillColor: disabledFillColor,
        textAlign: textAlign,
        fillColorEnabled: fillColorEnabled,
        hasBorder: hasBorder,
      );

  factory MPRTextField.searchField({
    Key? key,
    bool autoCorrect = false,
    String? label,
    String? hint,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    VoidCallback? onClear,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLength,
    int? maxLines = 1,
    Icon? prefixIcon,
    SuffixIconType? suffixIconType,
    Key? suffixIconKey,
    bool isError = false,
    FocusNode? focusNode,
    bool autofocus = false,
    EdgeInsets? contentPadding,
    Color? backgroundColor,
    double? height,
    bool sameFocusedFill = false,
    bool hasBorder = true,
    double? cornerRadius,
  }) =>
      MPRTextField._(
        key: key,
        autoCorrect: autoCorrect,
        label: label,
        hint: hint,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onClear: onClear,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        maxLines: maxLines,
        prefixIcon: prefixIcon,
        suffixIconType: suffixIconType,
        suffixIconKey: suffixIconKey,
        isError: isError,
        textFieldStyle: MPRTextFieldStyle.searchField,
        focusNode: focusNode,
        autofocus: autofocus,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor,
        height: height,
        sameFocusedFill: sameFocusedFill,
        hasBorder: hasBorder,
        cornerRadius: cornerRadius,
      );

  factory MPRTextField.comment({
    Key? key,
    String? hint,
    required TextEditingController controller,
    VoidCallback? onClear,
    int? maxLines = 1,
    bool isError = false,
    ValueChanged<String>? onChanged,
    SuffixIconType? suffixIconType,
  }) =>
      MPRTextField._(
        key: key,
        label: null,
        hint: hint,
        controller: controller,
        onClear: onClear,
        maxLines: maxLines,
        suffixIconType: suffixIconType,
        isError: isError,
        textFieldStyle: MPRTextFieldStyle.comment,
        onChanged: onChanged,
      );

  const MPRTextField._({
    super.key,
    this.autoCorrect = true,
    required this.label,
    this.hint,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onClear,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIconType,
    this.suffixIconOnPressed,
    this.suffixIconKey,
    this.maxLines,
    this.maxLength,
    this.isPassword = false,
    this.isError = false,
    this.isEnabled = true,
    this.isButton = false,
    this.disabledFillColor,
    required this.textFieldStyle,
    this.scrollPadding,
    this.contentPadding,
    this.textAlign,
    this.backgroundColor,
    this.suffixIconColor,
    this.textColor,
    this.suffixIconConstraints,
    this.autofocus = false,
    this.fillColorEnabled = true,
    this.hasBorder = true,
    this.whiteFill = false,
    this.expandSize = false,
    this.height,
    this.sameFocusedFill = false,
    this.cornerRadius,
  });

  @override
  State<MPRTextField> createState() => _MPRTextFieldState();
}

class _MPRTextFieldState extends State<MPRTextField> {
  late FocusNode focusNode;
  bool isPasswordHidden = true;

  void _rebuild() {
    if (mounted) {
      setState(() => {});
    }
  }

  @override
  void initState() {
    super.initState();

    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_rebuild);
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.textFieldStyle == MPRTextFieldStyle.outlinedCompact ||
        widget.textFieldStyle == MPRTextFieldStyle.quantity ||
        widget.textFieldStyle == MPRTextFieldStyle.searchField) {
      return SizedBox(
        height: widget.height ?? 40,
        child: _buildTextFormField(context),
      );
    }
    return _buildTextFormField(context);
  }

  Widget _buildTextFormField(BuildContext context) {
    final formFieldWidget = Material(
      borderRadius: BorderRadius.circular(4),
      color: ColorPalette.white,
      child: TextFormField(
        keyboardType:
            widget.expandSize ? TextInputType.multiline : widget.keyboardType,
        minLines: widget.expandSize ? null : 1,
        maxLines: widget.expandSize ? null : widget.maxLines,
        expands: widget.expandSize,
        textAlign: widget.textAlign ?? TextAlign.start,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        cursorColor: ColorPalette.gunmetal.withValues(alpha: 0.5),
        textAlignVertical: widget.expandSize ? TextAlignVertical.top : null,
        // Note: Autocorrect can only be disabled on Android if "enabledSuggestions" is also set to false.
        // Ironically, at this time, this does not actually disable keyboard suggestions.
        // More on this issue here: https://github.com/flutter/flutter/issues/71679
        autocorrect: widget.autoCorrect,
        enableSuggestions: widget.autoCorrect,
        maxLength: widget.maxLength,
        buildCounter: (
          BuildContext context, {
          required int currentLength,
          required int? maxLength,
          required bool isFocused,
        }) {
          return null;
        },
        enabled: widget.isEnabled,
        onChanged: widget.onChanged,
        onEditingComplete: () {
          widget.onEditingComplete?.call();
          focusNode.unfocus();
        },
        onTap: widget.onTap,
        style: _getTextStyle(),
        focusNode: focusNode,
        autofocus: widget.autofocus,
        controller: widget.controller,
        obscureText: widget.isPassword && isPasswordHidden,
        scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
        decoration: InputDecoration(
          fillColor: widget.whiteFill
              ? Colors.white
              : (widget.sameFocusedFill)
                  ? widget.backgroundColor
                  : focusNode.hasFocus
                      ? ColorPalette.gunmetal.shade100.withValues(alpha: 0.2)
                      : !widget.isEnabled && widget.disabledFillColor != null
                          ? widget.disabledFillColor
                          : widget.backgroundColor ??
                              ColorPalette.platinum.shade200,
          filled: widget.fillColorEnabled,
          contentPadding: widget.contentPadding ??
              ((widget.textFieldStyle == MPRTextFieldStyle.outlinedCompact ||
                      widget.textFieldStyle == MPRTextFieldStyle.searchField)
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  : (widget.textFieldStyle == MPRTextFieldStyle.quantity)
                      ? const EdgeInsets.all(8.0)
                      : const EdgeInsets.all(16.0)),
          labelText: widget.label,
          labelStyle: _getLabelStyle(),
          hintText: widget.hint,
          hintStyle: _getHintStyle(),
          floatingLabelBehavior: _getFloatingLabelBehavior(),
          enabledBorder: widget.textFieldStyle ==
                      MPRTextFieldStyle.outlinedCompact ||
                  (widget.textFieldStyle == MPRTextFieldStyle.filledSmall &&
                      widget.hasBorder) ||
                  widget.textFieldStyle == MPRTextFieldStyle.searchField
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.cornerRadius ?? 4),
                  borderSide: BorderSide(
                    color: widget.isError
                        ? ColorPalette.red
                        : ColorPalette.platinum.shade600,
                  ),
                )
              : InputBorder.none,
          focusedBorder: widget.textFieldStyle ==
                      MPRTextFieldStyle.filledSmall ||
                  (widget.textFieldStyle == MPRTextFieldStyle.quantity &&
                      widget.hasBorder) ||
                  (widget.textFieldStyle == MPRTextFieldStyle.searchField &&
                      widget.hasBorder)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.cornerRadius ?? 4),
                  borderSide: BorderSide(
                    color: widget.isError
                        ? ColorPalette.red
                        : ColorPalette.gunmetal.shade300,
                  ),
                )
              : (widget.textFieldStyle == MPRTextFieldStyle.searchField &&
                      !widget.hasBorder)
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: ColorPalette.platinum.shade500,
                      ),
                    )
                  : InputBorder.none,
          disabledBorder: widget.disabledFillColor != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.cornerRadius ?? 4),
                  borderSide: BorderSide(
                    color: widget.isError
                        ? ColorPalette.red
                        : widget.disabledFillColor!,
                  ),
                )
              : InputBorder.none,
          border: InputBorder.none,
          prefixIcon: (widget.prefixIcon != null)
              ? IconTheme(
                  data: IconThemeData(
                    color: widget.isError
                        ? ColorPalette.red
                        : ColorPalette.gunmetal.shade300,
                  ),
                  child: widget.prefixIcon!,
                )
              : null,
          suffixIcon: widget.suffixIconType != null
              ? _SuffixIcon(
                  key: widget.suffixIconKey,
                  textField: widget,
                  focusNode: focusNode,
                  isPasswordHidden: isPasswordHidden,
                  toggleVisibility: _togglePasswordVisibility,
                  suffixIconOnPressed: widget.suffixIconOnPressed,
                  color:
                      widget.suffixIconColor ?? ColorPalette.gunmetal.shade300,
                )
              : null,
          suffixIconConstraints: widget.suffixIconConstraints,
        ),
      ),
    );

    return Semantics(
      button: widget.isButton,
      child:
          // There is currently an open defect where disabled TextFormFields do not
          // show in Semantics. The below is a work-around for this.
          // https://github.com/flutter/flutter/issues/44737
          (widget.isEnabled)
              ? formFieldWidget
              : Semantics(
                  label: widget.label,
                  value: widget.controller.text,
                  hint: widget.controller.text.isEmpty ? widget.hint : "",
                  excludeSemantics: true,
                  child: formFieldWidget,
                ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  TextStyle _getTextStyle() {
    if (widget.textFieldStyle == MPRTextFieldStyle.information) {
      return MPRTextStyles.large.copyWith(
        color: widget.isError ? ColorPalette.red : null,
      );
    } else if (widget.textFieldStyle == MPRTextFieldStyle.quantity) {
      return MPRTextStyles.large
          .copyWith(color: widget.isError ? ColorPalette.red : null);
    } else if (widget.textFieldStyle == MPRTextFieldStyle.searchField ||
        widget.textFieldStyle == MPRTextFieldStyle.comment) {
      return MPRTextStyles.regular
          .copyWith(color: widget.isError ? ColorPalette.red : null);
    }
    return widget.textFieldStyle == MPRTextFieldStyle.filledSmall
        ? MPRTextStyles.large
            .copyWith(color: widget.isError ? ColorPalette.red : null)
        : MPRTextStyles.extraLargeSemiBold.copyWith(
            color: widget.isError ? ColorPalette.red : widget.textColor,
          );
  }

  TextStyle _getHintStyle() {
    if (widget.textFieldStyle == MPRTextFieldStyle.quantity) {
      return MPRTextStyles.large
          .copyWith(color: widget.isError ? ColorPalette.red : null);
    } else if (widget.textFieldStyle == MPRTextFieldStyle.information) {
      return MPRTextStyles.large
          .copyWith(color: ColorPalette.gunmetal.shade300);
    } else if (widget.textFieldStyle == MPRTextFieldStyle.searchField ||
        widget.textFieldStyle == MPRTextFieldStyle.comment) {
      return MPRTextStyles.regular
          .copyWith(color: ColorPalette.gunmetal.shade300);
    }
    return widget.textFieldStyle == MPRTextFieldStyle.filledSmall
        ? focusNode.hasFocus
            ? MPRTextStyles.largeSemiBold
                .copyWith(color: ColorPalette.gunmetal.shade300)
            : MPRTextStyles.large
                .copyWith(color: ColorPalette.gunmetal.shade300)
        : MPRTextStyles.extraLargeSemiBold.copyWith(
            color: widget.textColor ?? ColorPalette.gunmetal.shade300,
          );
  }

  TextStyle _getLabelStyle() {
    if (widget.textFieldStyle == MPRTextFieldStyle.information) {
      return MPRTextStyles.headline2.copyWith(
        height: 1,
      );
    } else if (widget.textFieldStyle == MPRTextFieldStyle.searchField) {
      return MPRTextStyles.regular
          .copyWith(color: ColorPalette.gunmetal.shade300);
    } else if (widget.textFieldStyle != MPRTextFieldStyle.filledSmall) {
      return MPRTextStyles.extraLargeSemiBold.copyWith(
        color: widget.isError
            ? ColorPalette.red
            : widget.textColor ?? ColorPalette.gunmetal.shade300,
      );
    }
    return focusNode.hasFocus
        ? MPRTextStyles.largeSemiBold.copyWith(
            color: widget.isError
                ? ColorPalette.red
                : widget.textColor ?? ColorPalette.gunmetal.shade300,
          )
        : MPRTextStyles.large.copyWith(
            color: widget.isError
                ? ColorPalette.red
                : widget.textColor ?? ColorPalette.gunmetal.shade300,
          );
  }

  FloatingLabelBehavior? _getFloatingLabelBehavior() {
    switch (widget.textFieldStyle) {
      case MPRTextFieldStyle.outlinedCompact:
      case MPRTextFieldStyle.searchField:
        return FloatingLabelBehavior.never;
      case MPRTextFieldStyle.quantity:
      case MPRTextFieldStyle.information:
        return FloatingLabelBehavior.always;
      default:
        return null;
    }
  }
}

class _SuffixIcon extends StatelessWidget {
  final MPRTextField textField;
  final FocusNode focusNode;
  final bool isPasswordHidden;
  final VoidCallback toggleVisibility;
  final VoidCallback? suffixIconOnPressed;
  final Color? color;
  const _SuffixIcon({
    super.key,
    required this.textField,
    required this.focusNode,
    required this.isPasswordHidden,
    required this.toggleVisibility,
    required this.suffixIconOnPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.read<AppTheme>();
    switch (textField.suffixIconType) {
      case SuffixIconType.clear:
        if (textField.controller.text.isNotEmpty && focusNode.hasFocus) {
          return IconButton(
            tooltip: 'Clear',
            onPressed: () {
              textField.controller.clear();
              textField.onClear?.call();
            },
            color: color ?? ColorPalette.gunmetal.shade300,
            icon: const Icon(Icons.clear),
          );
        } else {
          return const SizedBox.shrink();
        }
      case SuffixIconType.calendar:
        return IconButton(
          tooltip: 'Calendar',
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10.0),
          icon: SvgAdapter.asset(
            appTheme.images.calendar,
            color: color ?? ColorPalette.gunmetal,
            width: 20.0,
            height: 20.0,
          ),
          onPressed: () {},
        );
      case SuffixIconType.clock:
        return IconButton(
          tooltip: 'Clock',
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 18.0),
          icon: SvgAdapter.asset(
            appTheme.images.home,
            color: color ?? ColorPalette.gunmetal,
            width: 20.0,
            height: 20.0,
          ),
          onPressed: () {},
        );
      case SuffixIconType.edit:
        if (focusNode.hasFocus) {
          return const SizedBox.shrink();
        } else {
          return IconButton(
            tooltip: 'Edit',
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16.0),
            icon: SvgAdapter.asset(
              appTheme.images.home,
              color: color ?? ColorPalette.blue,
              width: 24.0,
              height: 24.0,
            ),
            onPressed: () {},
          );
        }
      case SuffixIconType.trash:
        return IconButton(
          tooltip: 'Clear',
          onPressed: () {
            if (suffixIconOnPressed != null) {
              suffixIconOnPressed!.call();
            } else {
              textField.onClear?.call();
            }
          },
          icon: ExcludeSemantics(
            child: SvgAdapter.asset(
              appTheme.images.home,
              color: color ?? ColorPalette.blue,
              width: 24.0,
              height: 24.0,
            ),
          ),
        );
      case SuffixIconType.remove:
        return IconButton(
          tooltip: 'Remove Item',
          onPressed: () {
            textField.onClear?.call();
          },
          color: color ?? ColorPalette.blue,
          icon: const Icon(Icons.clear),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

enum SuffixIconType {
  calendar,
  clock,
  clear,
  edit,
  trash,
  remove,
}

enum MPRTextFieldStyle {
  filled,
  filledSmall,
  outlinedCompact,
  quantity,
  information,
  searchField,
  comment,
}
