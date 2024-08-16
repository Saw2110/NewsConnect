import '../../../news/news.dart';
import '../../favourites.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.getFavorites();
  }
}
