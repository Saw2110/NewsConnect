import '../src/news/news.dart';
import 'locator.dart';

void newsLocator() {
  // Data sources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(apiProvider: sl()),
  );
  sl.registerLazySingleton<ArticleLocalDataSource>(
    () => ArticleLocalDataSourceImpl(database: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<GetArticlesUseCase>(
    () => GetArticlesUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<NewsBloc>(
    () => NewsBloc(sl()),
  );
}
