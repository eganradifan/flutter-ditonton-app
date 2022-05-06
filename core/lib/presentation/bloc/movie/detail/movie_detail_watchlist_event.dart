part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail tvShowDetail;
  AddWatchlist(this.tvShowDetail);
}

class RemoveFromWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail tvShowDetail;
  RemoveFromWatchlist(this.tvShowDetail);
}

class LoadWatchlistStatus extends MovieDetailWatchlistEvent {
  final int id;
  LoadWatchlistStatus(this.id);
}
