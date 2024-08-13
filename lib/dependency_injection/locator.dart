import 'package:get_it/get_it.dart';
import 'package:news_connect/core/core.dart';

import 'auth/auth_locator.dart';

final sl = GetIt.instance;

void locator() {
  sl.registerLazySingleton(() => NavigationService());

  /// [ Auth ]
  authLocator();

  ///
}
