library core;

export 'styles/colors.dart';
export 'styles/text_styles.dart';
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';
export 'utils/http_ssl_pinning.dart';

export 'data/datasources/db/database_helper.dart';
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_show_remote_data_source.dart';
export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tv_show_repository_impl.dart';

export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_show_repository.dart';
export 'domain/usecases/movie/get_movie_detail.dart';
export 'domain/usecases/movie/get_movie_recommendations.dart';
export 'domain/usecases/movie/get_now_playing_movies.dart';
export 'domain/usecases/tv_show/get_now_playing_tv_show.dart';
export 'domain/usecases/movie/get_popular_movies.dart';
export 'domain/usecases/movie/get_top_rated_movies.dart';
export 'domain/usecases/movie/get_watchlist_movies.dart';
export 'domain/usecases/movie/get_watchlist_status.dart';
export 'domain/usecases/movie/remove_watchlist.dart';
export 'domain/usecases/movie/save_watchlist.dart';

export 'domain/usecases/tv_show/get_popular_tv_shows.dart';
export 'domain/usecases/tv_show/get_top_rated_tv_shows.dart';
export 'domain/usecases/tv_show/get_tv_show_detail.dart';
export 'domain/usecases/tv_show/get_tv_show_recommendations.dart';
export 'domain/usecases/tv_show/get_tv_show_watchlist_status.dart';
export 'domain/usecases/tv_show/get_watchlist_tv_show.dart';
export 'domain/usecases/tv_show/tv_show_remove_watchlist.dart';
export 'domain/usecases/tv_show/tv_show_save_watchlist.dart';

export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/home_movie_page.dart';
export 'presentation/pages/now_playing_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/top_rated_movies_page.dart';
export 'presentation/pages/tv_show_detail_page.dart';
export 'presentation/pages/tv_show_list_page.dart';
export 'presentation/pages/watchlist_movies_page.dart';

export 'presentation/bloc/movie/detail/movie_detail_bloc.dart';
export 'presentation/bloc/movie/detail/movie_detail_recommendation_bloc.dart';
export 'presentation/bloc/movie/detail/movie_detail_watchlist_bloc.dart';
export 'presentation/bloc/movie/now_playing/movie_now_playing_bloc.dart';
export 'presentation/bloc/movie/popular/movie_popular_bloc.dart';
export 'presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
export 'presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';

export 'presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
export 'presentation/bloc/tv_show/detail/tv_show_detail_recommendation_bloc.dart';
export 'presentation/bloc/tv_show/detail/tv_show_detail_watchlist_bloc.dart';
export 'presentation/bloc/tv_show/now_playing/tv_show_now_playing_bloc.dart';
export 'presentation/bloc/tv_show/popular/tv_show_popular_bloc.dart';
export 'presentation/bloc/tv_show/top_rated/tv_show_top_rated_bloc.dart';
export 'presentation/bloc/tv_show/watchlist/tv_show_watchlist_bloc.dart';
