import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/tv_show_save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowSaveWatchlist usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = TvShowSaveWatchlist(mockTvShowRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchlist(tvShowDetailEntity))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(tvShowDetailEntity);
    // assert
    expect(result, const Right('Removed from watchlist'));
  });
}
