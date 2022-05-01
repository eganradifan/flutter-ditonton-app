import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/tv_show_top_rated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_show_top_rated_bloc.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late TvShowTopRatedBloc tvShowTopRatedBloc;
  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    tvShowTopRatedBloc = TvShowTopRatedBloc(mockGetTopRatedTvShows);
  });

  final tTvShowList = <TvShow>[tvShow];

  test('initial state should be empty', () {
    expect(tvShowTopRatedBloc.state, TvShowTopRatedEmpty());
  });

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowTopRatedLoading(),
      TvShowTopRatedHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowTopRatedLoading(),
      TvShowTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );
}
