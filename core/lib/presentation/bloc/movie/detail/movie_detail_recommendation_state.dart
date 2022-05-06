part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRecommendationState extends Equatable {
  const MovieDetailRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieDetailRecommendationEmpty extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoading extends MovieDetailRecommendationState {}

class MovieDetailRecommendationHasData extends MovieDetailRecommendationState {
  final List<Movie> result;
  MovieDetailRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailRecommendationError extends MovieDetailRecommendationState {
  final String message;

  MovieDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
