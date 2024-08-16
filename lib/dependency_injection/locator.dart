import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:news_connect/core/core.dart';
import 'package:sqflite/sqflite.dart';

import 'dependency_injection.dart';
import 'favourites_locator.dart';
import 'user_locator.dart';

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

  /// [ Firesbase ]
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  /// [ Auth ]
  authLocator();

  /// [ News ]
  newsLocator();

  /// [ Favourite ]
  favouriteLocator();

  /// [ User ]
  userLocator();

  ///
}
