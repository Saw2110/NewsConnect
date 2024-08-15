import 'package:dartz/dartz.dart';

import '../../../../core/apis/failure.dart';
import '../../news.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
}
