import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/modules/root.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/service_registrar.dart';

void main() {
  configApp();
}

Future<void> configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  //late Future appConfigurationFuture;
  late Future databaseConfigurationFuture;
  final orientationFuture =
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final getItFuture = ServiceRegistrar.init();
  Future.wait([
    orientationFuture,
    getItFuture,
  ]).then(
    (_) async => {
      // appConfigurationFuture =
      //     GetIt.I<AppConfigService>().loadFromAsset('assets/settings.json'),
      databaseConfigurationFuture = GetIt.I<DatabaseService>().createDatabase(),
      Future.wait([databaseConfigurationFuture])
          .then((value) => runApp(const Root())),
    },
  );
}
