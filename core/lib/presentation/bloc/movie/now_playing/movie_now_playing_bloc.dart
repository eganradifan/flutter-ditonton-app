import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          emit(MovieNowPlayingHasData(data));
        },
      );
    });
  }
}
