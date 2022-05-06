part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRecommendationEvent extends Equatable {
  const MovieDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends MovieDetailRecommendationEvent {
  final int id;
  FetchMovieRecommendation(this.id);
}
