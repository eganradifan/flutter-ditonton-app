import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_show/tv_show_remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show/tv_show_save_watchlist.dart';
import 'package:flutter/cupertino.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  final GetTvShowDetail getTvShowDetail;
  final GetTvShowsRecommendations getTvShowsRecommendations;
  final TvShowSaveWatchlist saveWatchlist;
  final GetTvShowWatchListStatus getWatchListStatus;
  final TvShowRemoveWatchlist removeWatchlist;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowsRecommendations,
    required this.saveWatchlist,
    required this.getWatchListStatus,
    required this.removeWatchlist,
  });

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  late TvShowDetail _tvShows;
  TvShowDetail get tvShows => _tvShows;

  List<TvShow> _tvShowsRecommendation = [];
  List<TvShow> get tvShowsRecommendation => _tvShowsRecommendation;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvShowDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowDetail.execute(id);
    final recommendationsResult = await getTvShowsRecommendations.execute(id);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowData) {
        _tvShows = tvShowData;
        _state = RequestState.Loading;
        notifyListeners();
        recommendationsResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvShowData) {
            _recommendationState = RequestState.Loaded;
            _tvShowsRecommendation = tvShowData;
          },
        );
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    final result = await saveWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    final result = await removeWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
