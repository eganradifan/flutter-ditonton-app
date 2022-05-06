import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_recommendation_event.dart';
part 'movie_detail_recommendation_state.dart';

class MovieDetailRecommendationBloc extends Bloc<MovieDetailRecommendationEvent,
    MovieDetailRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailRecommendationBloc(this.getMovieRecommendations)
      : super(MovieDetailRecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      emit(MovieDetailRecommendationLoading());
      final result = await getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieDetailRecommendationError(failure.message));
        },
        (tvShowData) {
          emit(MovieDetailRecommendationHasData(tvShowData));
        },
      );
    });
  }
}
