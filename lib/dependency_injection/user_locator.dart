import '../src/profile/profile.dart';
import 'locator.dart';

void userLocator() {
  // // Data sources
  // sl.registerLazySingleton<UserRepository>(
  //   () => UserRepository(),
  // );

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()),
  );

  // // Use cases
  sl.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<UserCubit>(
    () => UserCubit(
      firebaseAuth: sl(),
      updateUserUseCase: sl(),
      getUserUseCase: sl(),
    ),
  );
}
