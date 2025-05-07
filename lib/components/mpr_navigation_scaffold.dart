import 'package:flutter/material.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRNavigationScaffold extends StatelessWidget
    implements PreferredSizeWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool includeSafeArea;
  final bool whiteBackground;
  final Widget? floatingActionButton;

  const MPRNavigationScaffold({
    super.key,
    required this.navigatorKey,
    required this.appBar,
    required this.body,
    this.includeSafeArea = true,
    this.whiteBackground = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPopWithResult: (_) {
        // This [NavigatorPopHandler] will ensure that the entire navigation stack
        // for the Navigator below won't be popped if the Android back button is tapped.
        navigatorKey.currentState?.maybePop();
      },
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                backgroundColor: whiteBackground
                    ? Colors.white
                    : ColorPalette.gunmetal.shade50,
                appBar: appBar,
                body: includeSafeArea ? SafeArea(child: body) : body,
                floatingActionButton: floatingActionButton,
              );
            },
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
