import '../../../news/news.dart';
import '../../favourites.dart';

class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<void> call(Article article) async {
    return await repository.addFavorite(article);
  }
}
