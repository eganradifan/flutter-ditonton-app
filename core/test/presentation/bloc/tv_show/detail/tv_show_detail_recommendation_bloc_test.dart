import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowsRecommendations])
void main() {
  late MockGetTvShowsRecommendations mockGetTvShowsRecommendations;
  late TvShowDetailRecommendationBloc tvShowDetailBloc;

  setUp(() {
    mockGetTvShowsRecommendations = MockGetTvShowsRecommendations();
    tvShowDetailBloc =
        TvShowDetailRecommendationBloc(mockGetTvShowsRecommendations);
  });

  final tTvShowList = <TvShow>[tvShow];

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowDetailRecommendationEmpty());
  });

  blocTest<TvShowDetailRecommendationBloc, TvShowDetailRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowsRecommendations.execute(1668))
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowRecommendation(1668)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailRecommendationLoading(),
      TvShowDetailRecommendationHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvShowsRecommendations.execute(1668));
    },
  );

  blocTest<TvShowDetailRecommendationBloc, TvShowDetailRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTvShowsRecommendations.execute(1668))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowRecommendation(1668)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailRecommendationLoading(),
      TvShowDetailRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowsRecommendations.execute(1668));
    },
  );
}
