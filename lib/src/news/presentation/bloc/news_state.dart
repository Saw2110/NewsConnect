part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsSuccess extends NewsState {
  final List<Article> newsModel;
  const NewsSuccess({required this.newsModel});

  @override
  List<Object> get props => [newsModel];
}

final class NewsError extends NewsState {
  final String message;
  const NewsError({required this.message});

  @override
  List<Object> get props => [message];
}
