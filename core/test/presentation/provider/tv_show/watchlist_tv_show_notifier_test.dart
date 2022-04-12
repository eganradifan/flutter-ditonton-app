import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_show.dart';
import 'package:core/presentation/provider/tv_show/watchlist_tv_show_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_show_notifier_test.mocks.dart';

@GenerateMocks([GetWatchListTvShow])
void main() {
  late WatchlistTvShowNotifier provider;
  late MockGetWatchListTvShow mockGetWatchListTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTvShow = MockGetWatchListTvShow();
    provider = WatchlistTvShowNotifier(
      getTvShowWatchList: mockGetWatchListTvShow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchListTvShow.execute())
        .thenAnswer((_) async => Right([testWatchlisTvShow]));
    // act
    await provider.fetchWatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTvshows, [testWatchlisTvShow]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchListTvShow.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
