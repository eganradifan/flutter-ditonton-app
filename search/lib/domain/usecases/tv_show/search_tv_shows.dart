import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:dartz/dartz.dart';

class SearchTvShows {
  final TvShowRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
