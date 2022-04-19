import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/now_playing_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_show_detail_page.dart';
import 'package:core/presentation/pages/tv_show_list_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';

import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie/movie_list_notifier.dart';
import 'package:search/presentation/provider/movie/movie_search_notifier.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tv_show/tv_show_list_notifier.dart';
import 'package:search/presentation/provider/tv_show/tv_show_search_notifier.dart';
import 'package:core/presentation/provider/tv_show/popular_tv_shows_notifier.dart';
import 'package:core/presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import 'package:core/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:core/presentation/provider/tv_show/watchlist_tv_show_notifier.dart';
import 'package:core/presentation/provider/tv_show/now_playing_tv_show_notifier.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowsSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingTvShowNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvShowNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              final isTvShow = settings.arguments as bool;
              return CupertinoPageRoute(
                  builder: (_) => PopularMoviesPage(
                        isTvShow: isTvShow,
                      ),
                  settings: settings);
            case TopRatedMoviesPage.ROUTE_NAME:
              final isTvShow = settings.arguments as bool;
              return CupertinoPageRoute(
                  builder: (_) => TopRatedMoviesPage(isTvShow: isTvShow),
                  settings: settings);
            case NowPlayingPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => NowPlayingPage(), settings: settings);
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final isTvShow = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  isTvShow: isTvShow,
                ),
                settings: settings,
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvShowListPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvShowListPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
