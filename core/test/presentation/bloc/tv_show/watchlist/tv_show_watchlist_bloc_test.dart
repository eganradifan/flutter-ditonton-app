import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_show.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/tv_show_watchlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_show_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTvShow])
void main() {
  late MockGetWatchListTvShow mockGetWatchlistTvShows;
  late TvShowWatchlistBloc tvShowTopRatedBloc;
  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchListTvShow();
    tvShowTopRatedBloc = TvShowWatchlistBloc(mockGetWatchlistTvShows);
  });

  final tTvShowList = <TvShow>[tvShow];

  test('initial state should be empty', () {
    expect(tvShowTopRatedBloc.state, TvShowWatchlistEmpty());
  });

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowWatchlistLoading(),
      TvShowWatchlistHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowWatchlistLoading(),
      TvShowWatchlistError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}
