import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:core/presentation/bloc/tv_show/popular/tv_show_popular_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../provider/tv_show/popular_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late MockGetPopularTvShows mockGetPopularTvShows;
  late TvShowPopularBloc tvShowPopularBloc;
  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    tvShowPopularBloc = TvShowPopularBloc(mockGetPopularTvShows);
  });

  final tTvShowList = <TvShow>[tvShow];

  test('initial state should be empty', () {
    expect(tvShowPopularBloc.state, TvShowPopularEmpty());
  });

  blocTest<TvShowPopularBloc, TvShowPopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowPopularLoading(),
      TvShowPopularHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );

  blocTest<TvShowPopularBloc, TvShowPopularState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvShows()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowPopularLoading(),
      TvShowPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );
}
