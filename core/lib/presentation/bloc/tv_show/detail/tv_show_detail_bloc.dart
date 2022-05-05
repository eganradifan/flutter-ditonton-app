import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail getTvShowDetail;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvShowDetailBloc(
    this.getTvShowDetail,
  ) : super(TvShowDetailEmpty()) {
    on<FetchTvShowDetail>((event, emit) async {
      emit(TvShowDetailLoading());
      final result = await getTvShowDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(TvShowDetailError(failure.message));
        },
        (tvShowData) {
          emit(TvShowDetailHasData(tvShowData));
        },
      );
    });
  }
}
