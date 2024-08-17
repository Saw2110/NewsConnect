part of 'news_bloc.dart';

enum Status { none, loading, success, error }

class NewsState extends Equatable {
  final List<Article> newsModel;
  final String? errorMessage;
  final Status status;

  const NewsState({
    required this.newsModel,
    required this.status,
    this.errorMessage,
  });

  NewsState copyWith({
    List<Article>? newsModel,
    String? errorMessage,
    Status? status,
  }) {
    return NewsState(
      newsModel: newsModel ?? this.newsModel,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  factory NewsState.initial() {
    return const NewsState(newsModel: [], status: Status.none);
  }

  @override
  List<Object?> get props => [newsModel, errorMessage, status];
}


// sealed class NewsState extends Equatable {
//   const NewsState();

//   @override
//   List<Object> get props => [];
// }

// final class NewsInitial extends NewsState {}

// final class NewsLoading extends NewsState {}

// final class NewsSuccess extends NewsState {
//   final List<Article> newsModel;
//   const NewsSuccess({required this.newsModel});

//   @override
//   List<Object> get props => [newsModel];
// }

// final class NewsError extends NewsState {
//   final String message;
//   const NewsError({required this.message});

//   @override
//   List<Object> get props => [message];
// }
