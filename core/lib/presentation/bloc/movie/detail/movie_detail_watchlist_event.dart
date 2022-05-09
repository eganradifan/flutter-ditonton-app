part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddMovieWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail tvShowDetail;
  AddMovieWatchlist(this.tvShowDetail);
}

class RemoveMovieFromWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail tvShowDetail;
  RemoveMovieFromWatchlist(this.tvShowDetail);
}

class LoadMovieWatchlistStatus extends MovieDetailWatchlistEvent {
  final int id;
  LoadMovieWatchlistStatus(this.id);
}
