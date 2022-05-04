import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/tv_show_watchlist_bloc.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/widgets/movie_card_list.dart';
import '../../presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    Future.microtask(() =>
        BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
            .add(FetchWatchlistMovies()));
    Future.microtask(() =>
        BlocProvider.of<TvShowWatchlistBloc>(context, listen: false)
            .add(FetchWatchlistTvShows()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
        .add(FetchWatchlistMovies());
    BlocProvider.of<TvShowWatchlistBloc>(context, listen: false)
        .add(FetchWatchlistTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              const Tab(text: 'Movie'),
              const Tab(text: 'Tv Show'),
            ],
            controller: controller,
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            _movieWatchlistSection(),
            _tvShowsWatchlistSection(),
          ],
        ));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Widget _movieWatchlistSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
        builder: (context, state) {
          if (state is MovieWatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieWatchlistHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
            );
          } else if (state is MovieWatchlistError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _tvShowsWatchlistSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TvShowWatchlistBloc, TvShowWatchlistState>(
        builder: (context, state) {
          if (state is TvShowWatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvShowWatchlistHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.result[index];
                return TvShowCard(tvShow);
              },
              itemCount: state.result.length,
            );
          } else if (state is TvShowWatchlistError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
