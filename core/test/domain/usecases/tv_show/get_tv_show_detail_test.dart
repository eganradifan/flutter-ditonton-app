import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetTvShowDetail usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowDetail(mockTvShowRepository);
  });

  const tvShowsId = 1668;
  test('should get detail of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowDetail(tvShowsId))
        .thenAnswer((_) async => Right(tvShowDetailEntity));
    // act
    final result = await usecase.execute(tvShowsId);
    // assert
    expect(result, Right(tvShowDetailEntity));
  });
}
