import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/movie/now_playing/movie_now_playing_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  final tMovieList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
