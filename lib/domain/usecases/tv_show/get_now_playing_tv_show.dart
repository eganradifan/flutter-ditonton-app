import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetNowPlayingTvShows {
  final TvShowRepository repository;

  GetNowPlayingTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getNowPlayingTvShow();
  }
}
