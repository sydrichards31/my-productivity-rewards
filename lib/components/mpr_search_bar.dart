import 'package:flutter/material.dart';
import 'package:my_productive_rewards/components/components.dart';

class MPRSearchBar extends StatelessWidget {
  final Key? inputFieldKey;
  final String searchLabel;
  final TextEditingController searchController;
  final Function(String)? onQueryChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onClear;
  final MPRTextFieldStyle textFieldStyle;
  final bool isEnabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? backgroundColor;
  final EdgeInsets? contentPadding;
  final double? cornerRadius;

  const MPRSearchBar({
    super.key,
    this.inputFieldKey,
    required this.searchLabel,
    required this.searchController,
    this.textFieldStyle = MPRTextFieldStyle.searchField,
    this.onQueryChanged,
    this.onEditingComplete,
    this.onClear,
    this.isEnabled = true,
    this.focusNode,
    this.autofocus = false,
    this.backgroundColor,
    this.contentPadding,
    this.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    MPRTextField textField;

    textField = MPRTextField.searchField(
      label: searchLabel,
      hint: MediaQuery.of(context).accessibleNavigation ? searchLabel : null,
      controller: searchController,
      focusNode: focusNode,
      prefixIcon: const Icon(Icons.search),
      suffixIconType: SuffixIconType.clear,
      onChanged: onQueryChanged,
      onEditingComplete: onEditingComplete,
      onClear: onClear,
      autofocus: autofocus,
      contentPadding: contentPadding,
      backgroundColor: backgroundColor,
      cornerRadius: cornerRadius,
      height: 45,
    );

    return Semantics(
      container: true,
      child: textField,
    );
  }
}
