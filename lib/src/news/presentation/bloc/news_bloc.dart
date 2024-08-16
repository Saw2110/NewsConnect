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
  }

  Future<void> _getAllNews(
    GetAllNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(NewsLoading());

      final result = await getArticlesUseCase();

      result.fold(
        (failure) => emit(const NewsError(message: 'Failed to fetch articles')),
        (articles) => emit(NewsSuccess(newsModel: articles)),
      );
    } catch (e) {
      emit(NewsError(message: '$e'));
    }
  }
}
