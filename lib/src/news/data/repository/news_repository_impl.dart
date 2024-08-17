import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../news.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleModel>>> getArticles();
  Future<Either<Failure, List<ArticleModel>>> searchArticle(String text);
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
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(CacheFailure());
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

  @override
  Future<Either<Failure, List<ArticleModel>>> searchArticle(String text) async {
    if (await networkInfo.isConnected) {
      try {
        final articles = await remoteDataSource.getArticles();

        return Right(articles);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
