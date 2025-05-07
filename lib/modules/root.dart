import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/modules/tabs/tabs.dart';
import 'package:my_productive_rewards/services/navigation_service.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<StatefulWidget> createState() => RootState();
}

class RootState extends State<Root> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppThemes.theme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: GetIt.I<NavigationService>().navigatorKey,
            title: context.read<AppTheme>().appName,
            theme: ThemeData(
              primaryColor: ColorPalette.green,
              appBarTheme: AppBarTheme(
                backgroundColor: ColorPalette.green,
                foregroundColor: Colors.white,
                titleTextStyle:
                    MPRTextStyles.largeBold.copyWith(color: Colors.white),
              ),
              useMaterial3: false,
            ),
            home: const Tabs(),
          );
        },
      ),
    );
  }
}
