import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:search/search.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailWatchlistBloc>(),
        )
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
