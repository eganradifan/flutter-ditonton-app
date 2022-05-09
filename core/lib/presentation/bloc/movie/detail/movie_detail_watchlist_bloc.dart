import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_watchlist_event.dart';
part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistBloc
    extends Bloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;

  MovieDetailWatchlistBloc(
    this.saveWatchlist,
    this.getWatchListStatus,
    this.removeWatchlist,
  ) : super(MovieDetailWatchlistEmpty()) {
    on<AddMovieWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvShowDetail);

      await result.fold(
        (failure) async {
          emit(MovieDetailWatchlistActionError(failure.message));
        },
        (successMessage) async {
          emit(MovieDetailWatchlistActionSuccess(successMessage));
        },
      );
      add(LoadMovieWatchlistStatus(event.tvShowDetail.id));
    });

    on<RemoveMovieFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvShowDetail);

      await result.fold(
        (failure) async {
          emit(MovieDetailWatchlistActionError(failure.message));
        },
        (successMessage) async {
          emit(MovieDetailWatchlistActionSuccess(successMessage));
        },
      );
      add(LoadMovieWatchlistStatus(event.tvShowDetail.id));
    });

    on<LoadMovieWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(MovieWatchlistStatusLoaded(result));
    });
  }
}
