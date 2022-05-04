import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_show.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_watchlist_event.dart';
part 'tv_show_watchlist_state.dart';

class TvShowWatchlistBloc
    extends Bloc<TvShowWatchlistEvent, TvShowWatchlistState> {
  final GetWatchListTvShow getTvShowWatchList;
  TvShowWatchlistBloc(this.getTvShowWatchList) : super(TvShowWatchlistEmpty()) {
    on<FetchWatchlistTvShows>((event, emit) async {
      emit(TvShowWatchlistLoading());
      final result = await getTvShowWatchList.execute();
      result.fold(
        (failure) {
          emit(TvShowWatchlistError(failure.message));
        },
        (data) {
          emit(TvShowWatchlistHasData(data));
        },
      );
    });
  }
}
