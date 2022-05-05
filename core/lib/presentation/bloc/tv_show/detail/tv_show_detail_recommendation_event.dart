part of 'tv_show_detail_recommendation_bloc.dart';

abstract class TvShowDetailRecommendationEvent extends Equatable {
  const TvShowDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowRecommendation extends TvShowDetailRecommendationEvent {
  final int id;
  FetchTvShowRecommendation(this.id);
}
