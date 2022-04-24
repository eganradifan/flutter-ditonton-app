import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:search/utils/utils.dart';
part 'tv_show_search_event.dart';
part 'tv_show_search_state.dart';

class TvShowSearchBloc extends Bloc<TvShowSearchEvent, TvShowSearchState> {
  final SearchTvShows _searchTvShows;

  TvShowSearchBloc(this._searchTvShows) : super(TvShowSearchEmpty()) {
    on<OnTvShowQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvShowSearchLoading());
      final result = await _searchTvShows.execute(query);

      result.fold(
        (failure) {
          emit(TvShowSearchError(failure.message));
        },
        (data) {
          emit(TvShowSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
