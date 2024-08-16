import '../../../news/news.dart';
import '../../favourites.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(Article article);
  Future<void> removeFavorite(Article article);
  Future<List<Article>> getFavorites();
  Future<bool> isFavorite(Article article);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<void> addFavorite(Article article) {
    return localDataSource.addFavorite(article);
  }

  @override
  Future<void> removeFavorite(Article article) {
    return localDataSource.removeFavorite(article);
  }

  @override
  Future<List<Article>> getFavorites() async {
    final articles = await localDataSource.getFavorites();
    return articles.map((model) => model).toList();
  }

  @override
  Future<bool> isFavorite(Article article) {
    return localDataSource.isFavorite(article);
  }
}
