import '../../../news/news.dart';

class FavoriteState {
  final List<Article> favoriteArticles;

  FavoriteState({required this.favoriteArticles});

  FavoriteState copyWith({List<Article>? favoriteArticles}) {
    return FavoriteState(
      favoriteArticles: favoriteArticles ?? this.favoriteArticles,
    );
  }
}
