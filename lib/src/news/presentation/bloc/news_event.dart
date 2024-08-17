part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllNews extends NewsEvent {}

class NewsSearchEvent extends NewsEvent {
  final String? text;

  const NewsSearchEvent({this.text});

  @override
  List<Object?> get props => [text];
}
