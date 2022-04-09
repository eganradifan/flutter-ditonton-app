import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_show.dart';
import 'package:flutter/cupertino.dart';

class NowPlayingTvShowNotifier extends ChangeNotifier {
  final GetNowPlayingTvShows getNowPlayingTvShows;

  NowPlayingTvShowNotifier({required this.getNowPlayingTvShows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvShows.execute();

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
