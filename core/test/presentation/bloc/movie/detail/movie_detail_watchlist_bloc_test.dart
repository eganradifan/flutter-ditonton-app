import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_watchlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, GetWatchListStatus, RemoveWatchlist])
void main() {
  late MockSaveWatchlist mockMovieSaveWatchlist;
  late MockGetWatchListStatus mockGetMovieWatchListStatus;
  late MockRemoveWatchlist mockMovieRemoveWatchlist;
  late MovieDetailWatchlistBloc tvShowDetailWatchlistBloc;

  setUp(() {
    mockMovieSaveWatchlist = MockSaveWatchlist();
    mockGetMovieWatchListStatus = MockGetWatchListStatus();
    mockMovieRemoveWatchlist = MockRemoveWatchlist();
    tvShowDetailWatchlistBloc = MovieDetailWatchlistBloc(mockMovieSaveWatchlist,
        mockGetMovieWatchListStatus, mockMovieRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(tvShowDetailWatchlistBloc.state, MovieDetailWatchlistEmpty());
  });

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit MovieWatchlistStatusLoaded when data is gotten successfully',
    build: () {
      when(mockGetMovieWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockGetMovieWatchListStatus.execute(1));
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [ActionSuccess, StatusLoaded] when data is saved successfully',
    build: () {
      when(mockMovieSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Success"));
      when(mockGetMovieWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailWatchlistActionSuccess("Success"),
      MovieWatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockMovieSaveWatchlist.execute(testMovieDetail));
      verify(mockGetMovieWatchListStatus.execute(1));
    },
  );
  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit [ActionSuccess, StatusLoaded] when data is removed successfully',
    build: () {
      when(mockMovieRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Success"));
      when(mockGetMovieWatchListStatus.execute(1))
          .thenAnswer((_) async => false);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailWatchlistActionSuccess("Success"),
      MovieWatchlistStatusLoaded(false),
    ],
    verify: (bloc) {
      verify(mockMovieRemoveWatchlist.execute(testMovieDetail));
      verify(mockGetMovieWatchListStatus.execute(1));
    },
  );
  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit ActionError when fail add to watchlist',
    build: () {
      when(mockMovieSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetMovieWatchListStatus.execute(1))
          .thenAnswer((_) async => false);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailWatchlistActionError("Failed"),
      MovieWatchlistStatusLoaded(false),
    ],
    verify: (bloc) {
      verify(mockMovieSaveWatchlist.execute(testMovieDetail));
      verify(mockGetMovieWatchListStatus.execute(1));
    },
  );
  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'Should emit ActionError when fail remove to watchlist',
    build: () {
      when(mockMovieRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetMovieWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailWatchlistActionError("Failed"),
      MovieWatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockMovieRemoveWatchlist.execute(testMovieDetail));
      verify(mockGetMovieWatchListStatus.execute(1));
    },
  );
}
