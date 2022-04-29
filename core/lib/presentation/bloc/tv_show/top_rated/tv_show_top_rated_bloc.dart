import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_top_rated_event.dart';
part 'tv_show_top_rated_state.dart';

class TvShowTopRatedBloc
    extends Bloc<TvShowTopRatedEvent, TvShowTopRatedState> {
  final GetTopRatedTvShows _getTopRatedTvShows;
  TvShowTopRatedBloc(this._getTopRatedTvShows) : super(TvShowTopRatedEmpty()) {
    on<FetchTopRatedTvShows>((event, emit) async {
      emit(TvShowTopRatedLoading());
      final result = await _getTopRatedTvShows.execute();
      result.fold(
        (failure) {
          emit(TvShowTopRatedError(failure.message));
        },
        (data) {
          emit(TvShowTopRatedHasData(data));
        },
      );
    });
  }
}
