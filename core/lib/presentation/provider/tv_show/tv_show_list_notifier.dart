import '../../../utils/state_enum.dart';
import '../../../domain/entities/tv_show/tv_show.dart';
import '../../../domain/usecases/tv_show/get_now_playing_tv_show.dart';
import '../../../domain/usecases/tv_show/get_popular_tv_shows.dart';
import '../../../domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:flutter/cupertino.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _nowPlayingTvShows = <TvShow>[];
  List<TvShow> get nowPlayingTvShows => _nowPlayingTvShows;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;
  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getNowPlayingTvShows,
    required this.getTopRatedTvShows,
    required this.getPopularTvShows,
  });

  final GetNowPlayingTvShows getNowPlayingTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;
  final GetPopularTvShows getPopularTvShows;

  Future<void> fetchNowPlayingTvShows() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();
    final result = await getNowPlayingTvShows.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingTvShows = tvShowsData;
      notifyListeners();
    });
  }

  Future<void> fetcTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedTvShows.execute();
    result.fold((failure) {
      _topRatedTvShowsState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _topRatedTvShowsState = RequestState.Loaded;
      _topRatedTvShows = tvShowsData;
      notifyListeners();
    });
  }

  Future<void> fetcPopularTvShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();
    final result = await getPopularTvShows.execute();
    result.fold((failure) {
      _popularTvShowsState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _popularTvShowsState = RequestState.Loaded;
      _popularTvShows = tvShowsData;
      notifyListeners();
    });
  }
}
