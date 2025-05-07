import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/navigation_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';

class ServiceRegistrar {
  static Future<void> init() async {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());
    getIt.registerLazySingleton<NavigationService>(() => NavigationService());
    getIt.registerLazySingleton<PersistentStorageService>(
      () => PersistentStorageService(),
    );
  }
}
