import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_show/tv_show.dart';
import '../../repositories/tv_show_repository.dart';

class GetTvShowsRecommendations {
  final TvShowRepository repository;

  GetTvShowsRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getTvShowRecommendations(id);
  }
}
