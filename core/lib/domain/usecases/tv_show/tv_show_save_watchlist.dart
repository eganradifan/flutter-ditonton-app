import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_show/tv_show_detail.dart';
import '../../repositories/tv_show_repository.dart';

class TvShowSaveWatchlist {
  final TvShowRepository repository;

  TvShowSaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShowDetail) {
    return repository.saveWatchlist(tvShowDetail);
  }
}
