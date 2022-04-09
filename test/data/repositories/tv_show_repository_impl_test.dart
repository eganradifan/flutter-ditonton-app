import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_show/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tvShowModelList = <TvShowModel>[tvShowModel];
  final tvShowLocal = <TvShow>[tvShow];
  group('Now Playing Tv Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenAnswer((_) async => tvShowModelList);
      // act
      final result = await repository.getNowPlayingTvShow();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowLocal);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvShow();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvShow();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top rated tv show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => tvShowModelList);
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvShows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowLocal);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvShows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular tv show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenAnswer((_) async => tvShowModelList);
      // act
      final result = await repository.getPopularTvShow();
      // assert
      verify(mockRemoteDataSource.getPopularTvShows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowLocal);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShow();
      // assert
      verify(mockRemoteDataSource.getPopularTvShows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShow();
      // assert
      verify(mockRemoteDataSource.getPopularTvShows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Detail tv show', () {
    final tvsId = 1668;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tvsId))
          .thenAnswer((_) async => tvShowDetailModel);
      // act
      final result = await repository.getTvShowDetail(tvsId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tvsId));
      expect(result, equals(Right(tvShowDetailEntity)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tvsId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(tvsId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tvsId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tvsId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tvsId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tvsId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search tv show', () {
    final query = 'new show';
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(query))
          .thenAnswer((_) async => tvShowModelList);
      // act
      final result = await repository.searchTvShows(query);
      // assert
      verify(mockRemoteDataSource.searchTvShows(query));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowLocal);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(query))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShows(query);
      // assert
      verify(mockRemoteDataSource.searchTvShows(query));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(query))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShows(query);
      // assert
      verify(mockRemoteDataSource.searchTvShows(query));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Recommendation tv show', () {
    final query = 0123;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowsRecommendations(query))
          .thenAnswer((_) async => tvShowModelList);
      // act
      final result = await repository.getTvShowRecommendations(query);
      // assert
      verify(mockRemoteDataSource.getTvShowsRecommendations(query));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowLocal);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowsRecommendations(query))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecommendations(query);
      // assert
      verify(mockRemoteDataSource.getTvShowsRecommendations(query));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowsRecommendations(query))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecommendations(query);
      // assert
      verify(mockRemoteDataSource.getTvShowsRecommendations(query));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(tvShowDetailEntity);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(tvShowDetailEntity);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(tvShowDetailEntity);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(tvShowDetailEntity);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of tv show', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getWatchlistTvShow();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlisTvShow]);
    });
  });
}
