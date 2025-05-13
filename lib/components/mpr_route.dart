import 'package:flutter/material.dart';

/// Custom Route with an animation to slide in from the right.
class MPRRoute<T> extends MaterialPageRoute<T> {
  MPRRoute({
    required Widget widget,
    super.fullscreenDialog,
  }) : super(
          builder: (context) => widget,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final platform = Theme.of(context).platform;

    // For non-dialog iOS routes, use default transition to support swipe back gestures.
    if (platform == TargetPlatform.iOS && !fullscreenDialog) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }

    final offsetAnimation = animation.drive(
      Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ),
    );
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

class MobNoAnimationRoute<T> extends MaterialPageRoute<T> {
  MobNoAnimationRoute({
    required Widget widget,
  }) : super(
          builder: (context) => widget,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
