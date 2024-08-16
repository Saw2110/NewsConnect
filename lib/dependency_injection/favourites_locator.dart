import 'package:flutter/material.dart';

import '../src/favourites/favourites.dart';
import 'locator.dart';

void favouriteLocator() {
  // Data sources
  sl.registerLazySingleton<FavoriteLocalDataSource>(
    () => FavoriteLocalDataSourceImpl(database: sl()),
  );

  // Repositories
  sl.registerLazySingleton<FavoriteRepository>(
    () {
      debugPrint("FavoriteRepository registered");
      return FavoriteRepositoryImpl(sl());
    },
  );

  // Use cases
  sl.registerLazySingleton<AddFavoriteUseCase>(
    () => AddFavoriteUseCase(sl()),
  );
  sl.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(sl()),
  );
  sl.registerLazySingleton<RemoveFavoriteUseCase>(
    () => RemoveFavoriteUseCase(sl()),
  );
  sl.registerLazySingleton<IsFavoriteUseCase>(
    () => IsFavoriteUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<FavoriteCubit>(
    () => FavoriteCubit(
      removeFavoriteUseCase: sl(),
      addFavoriteUseCase: sl(),
      getFavoritesUseCase: sl(),
      isFavoriteUseCase: sl(),
    ),
  );
}
