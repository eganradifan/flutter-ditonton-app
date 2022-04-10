import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_show/tv_show_detail.dart';
import '../../repositories/tv_show_repository.dart';

class GetTvShowDetail {
  final TvShowRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
