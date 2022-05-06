part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistState extends Equatable {
  const MovieDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieDetailWatchlistEmpty extends MovieDetailWatchlistState {}

class MovieDetailWatchlistLoading extends MovieDetailWatchlistState {}

class MovieDetailWatchlistActionSuccess extends MovieDetailWatchlistState {
  final String message;
  MovieDetailWatchlistActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailWatchlistActionError extends MovieDetailWatchlistState {
  final String message;

  MovieDetailWatchlistActionError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusLoaded extends MovieDetailWatchlistState {
  final bool status;

  MovieWatchlistStatusLoaded(this.status);

  @override
  List<Object> get props => [status];
}
