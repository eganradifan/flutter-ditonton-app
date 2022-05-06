import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc tvShowDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    tvShowDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );
}
