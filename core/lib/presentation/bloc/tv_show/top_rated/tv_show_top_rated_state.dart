part of 'tv_show_top_rated_bloc.dart';

abstract class TvShowTopRatedState extends Equatable {
  const TvShowTopRatedState();

  @override
  List<Object> get props => [];
}

class TvShowTopRatedEmpty extends TvShowTopRatedState {}

class TvShowTopRatedLoading extends TvShowTopRatedState {}

class TvShowTopRatedHasData extends TvShowTopRatedState {
  final List<TvShow> result;

  TvShowTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowTopRatedError extends TvShowTopRatedState {
  final String message;

  TvShowTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
