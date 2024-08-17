import 'package:dartz/dartz.dart';

import '../../../../core/apis/failure.dart';
import '../../news.dart';

class GetArticlesUseCase {
  final ArticleRepository repository;

  GetArticlesUseCase(this.repository);

  Future<Either<Failure, List<Article>>> withParam(String text) async {
    return await repository.searchArticle(text);
  }

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getArticles();
  }
}
