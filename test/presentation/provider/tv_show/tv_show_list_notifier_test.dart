import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShows, GetTopRatedTvShows, GetNowPlayingTvShows])
void main() {
  late TvShowListNotifier provider;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    provider = TvShowListNotifier(
        getNowPlayingTvShows: mockGetNowPlayingTvShows,
        getPopularTvShows: mockGetPopularTvShows,
        getTopRatedTvShows: mockGetTopRatedTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShowList = <TvShow>[tvShow];

  group('now playing tv shows', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchNowPlayingTvShows();
      // assert
      verify(mockGetNowPlayingTvShows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchNowPlayingTvShows();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tv shows when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchNowPlayingTvShows();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvShows();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv shows', () {
    test('initialState should be Empty', () {
      expect(provider.popularTvShowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetcPopularTvShows();
      // assert
      verify(mockGetPopularTvShows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetcPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loading);
    });

    test('should change tv shows when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetcPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loaded);
      expect(provider.popularTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetcPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetcTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loading);
    });

    test('should change tv shows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetcTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loaded);
      expect(provider.topRatedTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetcTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
