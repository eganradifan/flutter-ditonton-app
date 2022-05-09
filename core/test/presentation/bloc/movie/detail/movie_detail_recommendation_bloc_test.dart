import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieDetailRecommendationBloc tvShowDetailBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    tvShowDetailBloc =
        MovieDetailRecommendationBloc(mockGetMovieRecommendations);
  });

  final tMovieList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, MovieDetailRecommendationEmpty());
  });

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(tMovieList));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendation(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendation(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );
}
