import '../../../utils/state_enum.dart';
import '../../../domain/entities/tv_show/tv_show.dart';
import '../../../domain/usecases/tv_show/get_watchlist_tv_show.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  var _watchlistTvshows = <TvShow>[];
  List<TvShow> get watchlistTvshows => _watchlistTvshows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvShowNotifier({required this.getTvShowWatchList});

  final GetWatchListTvShow getTvShowWatchList;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowWatchList.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvshows = tvShowData;
        notifyListeners();
      },
    );
  }
}
