import 'package:get_it/get_it.dart';
import 'package:test_doodle/core/services/i_preferences_service.dart';
import 'package:test_doodle/core/services/theme_service.dart';
import 'package:test_doodle/core/services/time_service/now_provider_service.dart';
import 'package:test_doodle/core/services/time_service/time_service.dart';
import 'package:test_doodle/core/services/transaction_service/i_transaction_db_service.dart';
import 'package:test_doodle/core_data/database/db_service.dart';
import 'package:test_doodle/core_data/database/transaction_db_service/transaction_db_service.dart';
import 'package:test_doodle/core_data/preferences/preferences_service.dart';
import 'package:test_doodle/router/navigator_service.dart';

final locator = GetIt.instance;

void removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

Future<void> configureDependencies() async {
  // core services
  locator.registerFactory(() => NowProviderService());
  locator.registerFactory(() => TimeService());
  locator.registerLazySingleton(() => ThemeService());

  // data services
  locator.registerLazySingleton(() => DBService());
  locator.registerFactory<ITransactionDBService>(() => TransactionDbService());
  locator.registerFactory<IPreferencesService>(() => PreferencesService());


  // router services
  locator.registerLazySingleton(() => NavigatorService());
}