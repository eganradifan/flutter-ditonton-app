import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  final tMovieList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
