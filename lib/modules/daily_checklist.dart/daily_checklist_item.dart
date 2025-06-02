import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DailyChecklistItem extends Equatable {
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey globalKey;

  const DailyChecklistItem({
    required this.controller,
    required this.focusNode,
    required this.globalKey,
  });

  @override
  List<Object?> get props => [
        controller,
        focusNode,
        globalKey,
      ];

  DailyChecklistItem copyWith({
    bool? isValid,
  }) {
    return DailyChecklistItem(
      controller: controller,
      focusNode: focusNode,
      globalKey: globalKey,
    );
  }
}
