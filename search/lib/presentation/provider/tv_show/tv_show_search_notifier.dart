import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:search/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:flutter/cupertino.dart';

class TvShowsSearchNotifier extends ChangeNotifier {
  final SearchTvShows searchTvShows;

  TvShowsSearchNotifier({required this.searchTvShows});
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowsSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowData) {
        _tvShows = tvShowData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
