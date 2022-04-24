import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:search/presentation/bloc/tv_show_search_bloc.dart';

import '../../dumm_data/dummy_objects.dart';
import 'tv_show_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowSearchBloc searchBloc;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    searchBloc = TvShowSearchBloc(mockSearchTvShows);
  });

  final tTvShowList = <TvShow>[tvShow];
  final tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchBloc.state, TvShowSearchEmpty());
  });

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnTvShowQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowSearchLoading(),
      TvShowSearchHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnTvShowQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowSearchLoading(),
      TvShowSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );
}
