import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getMovieWatchList;
  MovieWatchlistBloc(this.getMovieWatchList) : super(MovieWatchlistEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await getMovieWatchList.execute();
      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistHasData(data));
        },
      );
    });
  }
}
