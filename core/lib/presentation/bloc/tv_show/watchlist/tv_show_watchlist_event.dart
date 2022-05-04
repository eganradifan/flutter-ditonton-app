part of 'tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistEvent extends Equatable {
  const TvShowWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTvShows extends TvShowWatchlistEvent {}
