import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_watchlist_status.dart';
import 'package:core/domain/usecases/tv_show/tv_show_remove_watchlist.dart';
import 'package:core/domain/usecases/tv_show/tv_show_save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_detail_watchlist_event.dart';
part 'tv_show_detail_watchlist_state.dart';

class TvShowDetailWatchlistBloc
    extends Bloc<TvShowDetailWatchlistEvent, TvShowDetailWatchlistState> {
  final TvShowSaveWatchlist saveWatchlist;
  final GetTvShowWatchListStatus getWatchListStatus;
  final TvShowRemoveWatchlist removeWatchlist;

  TvShowDetailWatchlistBloc(
    this.saveWatchlist,
    this.getWatchListStatus,
    this.removeWatchlist,
  ) : super(TvShowDetailWatchlistEmpty()) {
    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvShowDetail);

      await result.fold(
        (failure) async {
          emit(TvShowDetailWatchlistActionError(failure.message));
        },
        (successMessage) async {
          emit(TvShowDetailWatchlistActionSuccess(successMessage));
        },
      );
      add(LoadWatchlistStatus(event.tvShowDetail.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvShowDetail);

      await result.fold(
        (failure) async {
          emit(TvShowDetailWatchlistActionError(failure.message));
        },
        (successMessage) async {
          emit(TvShowDetailWatchlistActionSuccess(successMessage));
        },
      );
      add(LoadWatchlistStatus(event.tvShowDetail.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(TvShowWatchlistStatusLoaded(result));
    });
  }
}
