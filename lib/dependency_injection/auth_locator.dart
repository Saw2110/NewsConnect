import '../src/auth/auth.dart';
import 'locator.dart';

void authLocator() {
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(sl()),
  );
}
