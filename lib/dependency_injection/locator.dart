import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:news_connect/core/core.dart';
import 'package:sqflite/sqflite.dart';

import 'dependency_injection.dart';

final sl = GetIt.instance;

Future<void> locator() async {
  /// [ NAVIGATION ]
  sl.registerLazySingleton(() => NavigationService());

  /// [ NETWORK AND CONNECTION ]
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());

  /// [ API ]
  sl.registerLazySingleton<APIProvider>(() => APIProvider());

  /// [ DATABASE ]
  Database database = await DatabaseProvider.instance.initiateDatabase();
  sl.registerLazySingleton<Database>(() => database);

  sl.registerLazySingleton<DatabaseProvider>(
    () => DatabaseProvider.instance,
  );

  /// [ Auth ]
  authLocator();

  /// [ News ]
  newsLocator();

  ///
}
