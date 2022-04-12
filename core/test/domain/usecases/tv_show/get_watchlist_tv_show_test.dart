import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetWatchListTvShow(mockTvShowRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvShowRepository.getWatchlistTvShow())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}
