import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetPopularTvShows usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetPopularTvShows(mockTvShowRepository);
  });

  final tvShows = <TvShow>[];
  test('should get list of popular tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getPopularTvShow())
        .thenAnswer((_) async => Right(tvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvShows));
  });
}
