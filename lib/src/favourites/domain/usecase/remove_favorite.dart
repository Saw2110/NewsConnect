import '../../../news/news.dart';
import '../../favourites.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase(this.repository);

  Future<void> call(Article article) async {
    return await repository.removeFavorite(article);
  }
}
