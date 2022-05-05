part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object> get props => [];
}

class TvShowDetailEmpty extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailHasData extends TvShowDetailState {
  final TvShowDetail result;
  TvShowDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  TvShowDetailError(this.message);

  @override
  List<Object> get props => [message];
}
