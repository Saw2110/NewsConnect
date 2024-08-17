import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_connect/src/news/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetArticlesUseCase getArticlesUseCase;

  late final _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  NewsBloc(this.getArticlesUseCase) : super(NewsState.initial()) {
    on<NewsEvent>((event, emit) {});
    on<GetAllNews>(_getAllNews);
    on<NewsSearchEvent>(_newsSearchEvent);
  }

  Future<void> _newsSearchEvent(
    NewsSearchEvent event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(newsModel: [], status: Status.loading),
      );
      if (event.text!.isEmpty) {
        emit(NewsState.initial());
      }
      final result = await getArticlesUseCase.withParam(event.text ?? "");
      result.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: 'Failed to fetch articles',
            status: Status.error,
          ),
        ),
        (articles) => emit(
          state.copyWith(newsModel: articles, status: Status.success),
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  Future<void> _getAllNews(
    GetAllNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(newsModel: [], status: Status.loading),
      );

      final result = await getArticlesUseCase();

      result.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: 'Failed to fetch articles',
            status: Status.error,
          ),
        ),
        (articles) => emit(
          state.copyWith(newsModel: articles, status: Status.success),
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }
}
