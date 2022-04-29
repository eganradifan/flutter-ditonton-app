part of 'tv_show_now_playing_bloc.dart';

abstract class TvShowNowPlayingEvent extends Equatable {
  const TvShowNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingTvShows extends TvShowNowPlayingEvent {}
