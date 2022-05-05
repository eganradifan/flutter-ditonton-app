part of 'tv_show_detail_watchlist_bloc.dart';

abstract class TvShowDetailWatchlistState extends Equatable {
  const TvShowDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class TvShowDetailWatchlistEmpty extends TvShowDetailWatchlistState {}

class TvShowDetailWatchlistLoading extends TvShowDetailWatchlistState {}

class TvShowDetailWatchlistActionSuccess extends TvShowDetailWatchlistState {
  final String message;
  TvShowDetailWatchlistActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowDetailWatchlistActionError extends TvShowDetailWatchlistState {
  final String message;

  TvShowDetailWatchlistActionError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowWatchlistStatusLoaded extends TvShowDetailWatchlistState {
  final bool status;

  TvShowWatchlistStatusLoaded(this.status);

  @override
  List<Object> get props => [status];
}
