part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetAllNews extends NewsEvent {}

class SaveNewsToFavourite extends NewsEvent {}
