import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:core/presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late TopRatedTvShowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    notifier =
        TopRatedTvShowsNotifier(getTopRatedTvShows: mockGetTopRatedTvShows)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tTvShowList = <TvShow>[tvShow];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    notifier.fetchTopRatedTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    await notifier.fetchTopRatedTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
