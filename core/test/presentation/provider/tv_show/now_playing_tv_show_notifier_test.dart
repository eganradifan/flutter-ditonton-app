import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_now_playing_tv_show.dart';
import 'package:core/presentation/provider/tv_show/now_playing_tv_show_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows])
void main() {
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  late NowPlayingTvShowNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    notifier =
        NowPlayingTvShowNotifier(getNowPlayingTvShows: mockGetNowPlayingTvShows)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tTvShowList = <TvShow>[tvShow];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    await notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTvShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
