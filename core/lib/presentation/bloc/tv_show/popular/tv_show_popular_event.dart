part of 'tv_show_popular_bloc.dart';

abstract class TvShowPopularEvent extends Equatable {
  const TvShowPopularEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularTvShows extends TvShowPopularEvent {}
