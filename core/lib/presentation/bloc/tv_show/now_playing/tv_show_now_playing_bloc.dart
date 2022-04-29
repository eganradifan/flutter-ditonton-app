import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_now_playing_tv_show.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_now_playing_event.dart';
part 'tv_show_now_playing_state.dart';

class TvShowNowPlayingBloc
    extends Bloc<TvShowNowPlayingEvent, TvShowNowPlayingState> {
  final GetNowPlayingTvShows _getNowPlayingTvShows;

  TvShowNowPlayingBloc(this._getNowPlayingTvShows)
      : super(TvShowNowPlayingEmpty()) {
    on<FetchNowPlayingTvShows>((event, emit) async {
      emit(TvShowNowPlayingLoading());
      final result = await _getNowPlayingTvShows.execute();
      result.fold(
        (failure) {
          emit(TvShowNowPlayingError(failure.message));
        },
        (data) {
          emit(TvShowNowPlayingHasData(data));
        },
      );
    });
  }
}
