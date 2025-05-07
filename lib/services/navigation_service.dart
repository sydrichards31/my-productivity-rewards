import 'package:flutter/material.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> push<T>({
    required Widget widget,
  }) async {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.push<T>(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
    }
    return null;
  }

  void pop<T>({T? result}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pop<T>(result);
    }
  }
}
