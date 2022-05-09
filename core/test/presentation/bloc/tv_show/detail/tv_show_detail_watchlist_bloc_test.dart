import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_watchlist_status.dart';
import 'package:core/domain/usecases/tv_show/tv_show_remove_watchlist.dart';
import 'package:core/domain/usecases/tv_show/tv_show_save_watchlist.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_watchlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [TvShowSaveWatchlist, GetTvShowWatchListStatus, TvShowRemoveWatchlist])
void main() {
  late MockTvShowSaveWatchlist mockTvShowSaveWatchlist;
  late MockGetTvShowWatchListStatus mockGetTvShowWatchListStatus;
  late MockTvShowRemoveWatchlist mockTvShowRemoveWatchlist;
  late TvShowDetailWatchlistBloc tvShowDetailWatchlistBloc;

  setUp(() {
    mockTvShowSaveWatchlist = MockTvShowSaveWatchlist();
    mockGetTvShowWatchListStatus = MockGetTvShowWatchListStatus();
    mockTvShowRemoveWatchlist = MockTvShowRemoveWatchlist();
    tvShowDetailWatchlistBloc = TvShowDetailWatchlistBloc(
        mockTvShowSaveWatchlist,
        mockGetTvShowWatchListStatus,
        mockTvShowRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(tvShowDetailWatchlistBloc.state, TvShowDetailWatchlistEmpty());
  });

  blocTest<TvShowDetailWatchlistBloc, TvShowDetailWatchlistState>(
    'Should emit TvShowWatchlistStatusLoaded when data is gotten successfully',
    build: () {
      when(mockGetTvShowWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowWatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockGetTvShowWatchListStatus.execute(1));
    },
  );

  blocTest<TvShowDetailWatchlistBloc, TvShowDetailWatchlistState>(
    'Should emit [ActionSuccess, StatusLoaded] when data is saved successfully',
    build: () {
      when(mockTvShowSaveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => const Right("Success"));
      when(mockGetTvShowWatchListStatus.execute(1668))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(tvShowDetailEntity)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailWatchlistActionSuccess("Success"),
      TvShowWatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockTvShowSaveWatchlist.execute(tvShowDetailEntity));
      verify(mockGetTvShowWatchListStatus.execute(1668));
    },
  );
  blocTest<TvShowDetailWatchlistBloc, TvShowDetailWatchlistState>(
    'Should emit [ActionSuccess, StatusLoaded] when data is removed successfully',
    build: () {
      when(mockTvShowRemoveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => const Right("Success"));
      when(mockGetTvShowWatchListStatus.execute(1668))
          .thenAnswer((_) async => false);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tvShowDetailEntity)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailWatchlistActionSuccess("Success"),
      TvShowWatchlistStatusLoaded(false),
    ],
    verify: (bloc) {
      verify(mockTvShowRemoveWatchlist.execute(tvShowDetailEntity));
      verify(mockGetTvShowWatchListStatus.execute(1668));
    },
  );
  blocTest<TvShowDetailWatchlistBloc, TvShowDetailWatchlistState>(
    'Should emit ActionError when fail add to watchlist',
    build: () {
      when(mockTvShowSaveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvShowWatchListStatus.execute(1668))
          .thenAnswer((_) async => false);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(tvShowDetailEntity)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailWatchlistActionError("Failed"),
      TvShowWatchlistStatusLoaded(false),
    ],
    verify: (bloc) {
      verify(mockTvShowSaveWatchlist.execute(tvShowDetailEntity));
      verify(mockGetTvShowWatchListStatus.execute(1668));
    },
  );
  blocTest<TvShowDetailWatchlistBloc, TvShowDetailWatchlistState>(
    'Should emit ActionError when fail remove to watchlist',
    build: () {
      when(mockTvShowRemoveWatchlist.execute(tvShowDetailEntity))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvShowWatchListStatus.execute(1668))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tvShowDetailEntity)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailWatchlistActionError("Failed"),
      TvShowWatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockTvShowRemoveWatchlist.execute(tvShowDetailEntity));
      verify(mockGetTvShowWatchListStatus.execute(1668));
    },
  );
}
