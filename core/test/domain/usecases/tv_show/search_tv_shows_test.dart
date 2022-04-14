import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import '../../../../../search/lib/domain/usecase/tv_show/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late SearchTvShows usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  final tvShowName = 'Digimon';
  final tvShows = <TvShow>[];

  test('should get list of top rated tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShows(tvShowName))
        .thenAnswer((_) async => Right(tvShows));
    // act
    final result = await usecase.execute(tvShowName);
    // assert
    expect(result, Right(tvShows));
  });
}
