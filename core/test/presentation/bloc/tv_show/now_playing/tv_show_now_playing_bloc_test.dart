import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_show_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows])
void main() {
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  late TvShowNowPlayingBloc tvShowNowPlayingBloc;
  setUp(() {
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    tvShowNowPlayingBloc = TvShowNowPlayingBloc(mockGetNowPlayingTvShows);
  });

  final tTvShowList = <TvShow>[tvShow];

  test('initial state should be empty', () {
    expect(tvShowNowPlayingBloc.state, TvShowNowPlayingEmpty());
  });

  blocTest<TvShowNowPlayingBloc, TvShowNowPlayingState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowNowPlayingLoading(),
      TvShowNowPlayingHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvShows.execute());
    },
  );

  blocTest<TvShowNowPlayingBloc, TvShowNowPlayingState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowNowPlayingLoading(),
      TvShowNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvShows.execute());
    },
  );
}
