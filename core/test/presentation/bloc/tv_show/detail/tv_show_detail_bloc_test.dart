import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late MockGetTvShowDetail mockGetTvShowDetail;
  late TvShowDetailBloc tvShowDetailBloc;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(mockGetTvShowDetail);
  });

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowDetailEmpty());
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowDetail.execute(1668))
          .thenAnswer((_) async => Right(tvShowDetailEntity));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowDetail(1668)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailHasData(tvShowDetailEntity),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(1668));
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(1668))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowDetail(1668)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(1668));
    },
  );
}
