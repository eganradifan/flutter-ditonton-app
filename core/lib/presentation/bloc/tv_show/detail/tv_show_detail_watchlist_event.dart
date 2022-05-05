part of 'tv_show_detail_watchlist_bloc.dart';

abstract class TvShowDetailWatchlistEvent extends Equatable {
  const TvShowDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends TvShowDetailWatchlistEvent {
  final TvShowDetail tvShowDetail;
  AddWatchlist(this.tvShowDetail);
}

class RemoveFromWatchlist extends TvShowDetailWatchlistEvent {
  final TvShowDetail tvShowDetail;
  RemoveFromWatchlist(this.tvShowDetail);
}

class LoadWatchlistStatus extends TvShowDetailWatchlistEvent {
  final int id;
  LoadWatchlistStatus(this.id);
}
