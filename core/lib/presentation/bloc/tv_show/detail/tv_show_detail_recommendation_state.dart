part of 'tv_show_detail_recommendation_bloc.dart';

abstract class TvShowDetailRecommendationState extends Equatable {
  const TvShowDetailRecommendationState();

  @override
  List<Object> get props => [];
}

class TvShowDetailRecommendationEmpty extends TvShowDetailRecommendationState {}

class TvShowDetailRecommendationLoading
    extends TvShowDetailRecommendationState {}

class TvShowDetailRecommendationHasData
    extends TvShowDetailRecommendationState {
  final List<TvShow> result;
  TvShowDetailRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowDetailRecommendationError extends TvShowDetailRecommendationState {
  final String message;

  TvShowDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
