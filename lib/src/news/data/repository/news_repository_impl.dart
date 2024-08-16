import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../news.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleModel>>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    if (await networkInfo.isConnected) {
      try {
        final articles = await remoteDataSource.getArticles();
        localDataSource.saveArticles(articles);

        return Right(articles);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDataSource.getArticles();
        return Right(localData);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
  }
}
