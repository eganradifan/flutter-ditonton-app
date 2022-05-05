import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_detail_recommendation_event.dart';
part 'tv_show_detail_recommendation_state.dart';

class TvShowDetailRecommendationBloc extends Bloc<
    TvShowDetailRecommendationEvent, TvShowDetailRecommendationState> {
  final GetTvShowsRecommendations getTvShowsRecommendations;

  TvShowDetailRecommendationBloc(this.getTvShowsRecommendations)
      : super(TvShowDetailRecommendationEmpty()) {
    on<FetchTvShowRecommendation>((event, emit) async {
      emit(TvShowDetailRecommendationLoading());
      final result = await getTvShowsRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvShowDetailRecommendationError(failure.message));
        },
        (tvShowData) {
          emit(TvShowDetailRecommendationHasData(tvShowData));
        },
      );
    });
  }
}
