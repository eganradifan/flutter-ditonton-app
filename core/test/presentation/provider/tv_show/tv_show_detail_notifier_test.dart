import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_watchlist_status.dart';
import 'package:core/domain/usecases/tv_show/tv_show_remove_watchlist.dart';
import 'package:core/domain/usecases/tv_show/tv_show_save_watchlist.dart';
import 'package:core/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowsRecommendations,
  GetTvShowWatchListStatus,
  TvShowSaveWatchlist,
  TvShowRemoveWatchlist
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowsRecommendations mockGetTvShowsRecommendations;
  late MockGetTvShowWatchListStatus mockGetTvShowWatchListStatus;
  late MockTvShowSaveWatchlist mockTvShowSaveWatchlist;
  late MockTvShowRemoveWatchlist mockTvShowRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowsRecommendations = MockGetTvShowsRecommendations();
    mockGetTvShowWatchListStatus = MockGetTvShowWatchListStatus();
    mockTvShowSaveWatchlist = MockTvShowSaveWatchlist();
    mockTvShowRemoveWatchlist = MockTvShowRemoveWatchlist();
    provider = TvShowDetailNotifier(
      getTvShowsRecommendations: mockGetTvShowsRecommendations,
      getTvShowDetail: mockGetTvShowDetail,
      getWatchListStatus: mockGetTvShowWatchListStatus,
      saveWatchlist: mockTvShowSaveWatchlist,
      removeWatchlist: mockTvShowRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShowList = <TvShow>[tvShow];
  const tId = 163461;

  void _arrangeUsecase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(tvShowDetailEntity));
    when(mockGetTvShowsRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShowList));
  }

  group('Get TvShow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowsRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvShows, tvShowDetailEntity);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv show when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvShowsRecommendation, tTvShowList);
    });
  });

  group('Get TvShow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowsRecommendations.execute(tId));
      expect(provider.tvShowsRecommendation, tTvShowList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvShowsRecommendation, tTvShowList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(tvShowDetailEntity));
      when(mockGetTvShowsRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvShowWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockTvShowSaveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetTvShowWatchListStatus.execute(tvShowDetailEntity.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(tvShowDetailEntity);
      // assert
      verify(mockTvShowSaveWatchlist.execute(tvShowDetailEntity));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockTvShowRemoveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetTvShowWatchListStatus.execute(tvShowDetailEntity.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(tvShowDetailEntity);
      // assert
      verify(mockTvShowRemoveWatchlist.execute(tvShowDetailEntity));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockTvShowSaveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetTvShowWatchListStatus.execute(tvShowDetailEntity.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(tvShowDetailEntity);
      // assert
      verify(mockGetTvShowWatchListStatus.execute(tvShowDetailEntity.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockTvShowSaveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvShowWatchListStatus.execute(tvShowDetailEntity.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(tvShowDetailEntity);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });
  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowsRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
