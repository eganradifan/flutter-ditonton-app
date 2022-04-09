import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowsRecommendations {
  final TvShowRepository repository;

  GetTvShowsRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getTvShowRecommendations(id);
  }
}
