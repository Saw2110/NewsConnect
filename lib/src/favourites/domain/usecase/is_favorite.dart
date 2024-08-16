import '../../../news/news.dart';
import '../../favourites.dart';

class IsFavoriteUseCase {
  final FavoriteRepository repository;

  IsFavoriteUseCase(this.repository);

  Future<bool> call(Article article) async {
    return await repository.isFavorite(article);
  }
}
