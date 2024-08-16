import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news/news.dart';
import '../../favourites.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;

  FavoriteCubit({
    required this.removeFavoriteUseCase,
    required this.addFavoriteUseCase,
    required this.getFavoritesUseCase,
    required this.isFavoriteUseCase,
  }) : super(FavoriteState(favoriteArticles: []));

  Future<void> loadFavorites() async {
    final favorites = await getFavoritesUseCase();
    emit(state.copyWith(favoriteArticles: favorites));
  }

  Future<void> addFavorite(Article article) async {
    await addFavoriteUseCase(article);
    await loadFavorites();
  }

  Future<void> removeFavorite(Article article) async {
    await removeFavoriteUseCase(article);
    await loadFavorites();
  }

  bool isFavorite(Article article) {
    return state.favoriteArticles.contains(article);
  }
}
