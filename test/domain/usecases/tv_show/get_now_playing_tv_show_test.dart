import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetNowPlayingTvShows usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetNowPlayingTvShows(mockTvShowRepository);
  });

  final tvShows = <TvShow>[];
  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getNowPlayingTvShow())
        .thenAnswer((_) async => Right(tvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvShows));
  });
}
