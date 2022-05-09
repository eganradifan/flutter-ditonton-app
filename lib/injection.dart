import 'package:core/core.dart';
import 'package:search/search.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowsRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowWatchListStatus(locator()));
  locator.registerLazySingleton(() => TvShowSaveWatchlist(locator()));
  locator.registerLazySingleton(() => TvShowRemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListTvShow(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => MovieNowPlayingBloc(locator()));
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieTopRatedBloc(locator()));
  locator.registerFactory(() => MovieWatchlistBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieDetailRecommendationBloc(locator()));
  locator.registerFactory(
      () => MovieDetailWatchlistBloc(locator(), locator(), locator()));
  locator.registerFactory(() => TvShowNowPlayingBloc(locator()));
  locator.registerFactory(() => TvShowPopularBloc(locator()));
  locator.registerFactory(() => TvShowTopRatedBloc(locator()));
  locator.registerFactory(() => TvShowSearchBloc(locator()));
  locator.registerFactory(() => TvShowWatchlistBloc(locator()));
  locator.registerFactory(() => TvShowDetailBloc(locator()));
  locator.registerFactory(() => TvShowDetailRecommendationBloc(locator()));
  locator.registerFactory(
      () => TvShowDetailWatchlistBloc(locator(), locator(), locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
