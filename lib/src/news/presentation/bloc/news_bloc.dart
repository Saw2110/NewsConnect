import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_connect/src/news/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetArticlesUseCase getArticlesUseCase;

  NewsBloc(this.getArticlesUseCase) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {});
    on<GetAllNews>(_getAllNews);
    on<SaveNewsToFavourite>(_saveToFavourite);
  }

  Future<void> _getAllNews(
    GetAllNews event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    final result = await getArticlesUseCase();

    result.fold(
      (failure) => emit(const NewsError(message: 'Failed to fetch articles')),
      (articles) => emit(NewsSuccess(newsModel: articles)),
    );
  }

  Future<void> _saveToFavourite(
    SaveNewsToFavourite event,
    Emitter<NewsState> emit,
  ) async {
    // Implementation for saving news to favorites
  }
}
