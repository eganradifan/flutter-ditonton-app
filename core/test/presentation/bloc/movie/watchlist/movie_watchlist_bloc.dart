import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MovieWatchlistBloc tvShowTopRatedBloc;
  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    tvShowTopRatedBloc = MovieWatchlistBloc(mockGetWatchlistMovies);
  });

  final tMovieList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(tvShowTopRatedBloc.state, MovieWatchlistEmpty());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
