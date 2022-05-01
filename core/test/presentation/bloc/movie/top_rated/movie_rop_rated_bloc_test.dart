import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_rop_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final tMovieList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
