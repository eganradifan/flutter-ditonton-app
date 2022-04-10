import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_show/tv_show.dart';
import '../../repositories/tv_show_repository.dart';

class GetPopularTvShows {
  final TvShowRepository repository;

  GetPopularTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvShow();
  }
}
