import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:search/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:search/presentation/provider/tv_show/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dumm_data/dummy_objects.dart';
import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowsSearchNotifier provider;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShows = MockSearchTvShows();
    provider = TvShowsSearchNotifier(searchTvShows: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShowList = <TvShow>[tvShow];
  final tQuery = 'new show';

  group('search tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTvShowsSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowsSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowsSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
