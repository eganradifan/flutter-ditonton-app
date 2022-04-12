import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetTvShowsRecommendations usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowsRecommendations(mockTvShowRepository);
  });

  final tvShowsId = 1668;
  final tvShows = <TvShow>[];

  test('should get list of top rated tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowRecommendations(tvShowsId))
        .thenAnswer((_) async => Right(tvShows));
    // act
    final result = await usecase.execute(tvShowsId);
    // assert
    expect(result, Right(tvShows));
  });
}
