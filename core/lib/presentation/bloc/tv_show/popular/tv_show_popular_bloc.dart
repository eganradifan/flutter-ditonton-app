import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_popular_event.dart';
part 'tv_show_popular_state.dart';

class TvShowPopularBloc extends Bloc<TvShowPopularEvent, TvShowPopularState> {
  final GetPopularTvShows _getPopularTvShows;
  TvShowPopularBloc(this._getPopularTvShows) : super(TvShowPopularEmpty()) {
    on<FetchPopularTvShows>((event, emit) async {
      emit(TvShowPopularLoading());
      final result = await _getPopularTvShows.execute();
      result.fold(
        (failure) {
          emit(TvShowPopularError(failure.message));
        },
        (data) {
          emit(TvShowPopularHasData(data));
        },
      );
    });
  }
}
