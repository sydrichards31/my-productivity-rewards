import 'package:flutter/material.dart';
import 'package:my_productive_rewards/modules/tabs/bottom_tab_type.dart';

class BottomTabBarItem {
  final BottomTabType tabType;
  final String title;
  final WidgetBuilder builder;
  final String icon;
  final String label;

  BottomTabBarItem({
    required this.tabType,
    required this.title,
    required this.icon,
    required this.label,
    required this.builder,
  });
}
