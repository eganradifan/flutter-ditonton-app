import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_show/tv_show_remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRemoveWatchlist usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = TvShowRemoveWatchlist(mockTvShowRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvShowRepository.removeWatchlist(tvShowDetailEntity))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(tvShowDetailEntity);
    // assert
    expect(result, Right('Removed from watchlist'));
  });
}
