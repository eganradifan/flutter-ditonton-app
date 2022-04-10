import '../../../utils/state_enum.dart';
import '../../presentation/provider/movie/popular_movies_notifier.dart';
import '../../presentation/provider/tv_show/popular_tv_shows_notifier.dart';
import '../../presentation/widgets/movie_card_list.dart';
import '../../presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';
  final bool isTvShow;
  PopularMoviesPage({this.isTvShow = false});
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    if (widget.isTvShow) {
      Future.microtask(() =>
          Provider.of<PopularTvShowsNotifier>(context, listen: false)
              .fetchPopularTvShows());
    } else {
      Future.microtask(() =>
          Provider.of<PopularMoviesNotifier>(context, listen: false)
              .fetchPopularMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.isTvShow ? _renderTvShows() : _renderMovies()),
    );
  }

  Widget _renderTvShows() {
    return Consumer<PopularTvShowsNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvShow = data.tvShows[index];
              return TvShowCard(tvShow);
            },
            itemCount: data.tvShows.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  Widget _renderMovies() {
    return Consumer<PopularMoviesNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.movies[index];
              return MovieCard(movie);
            },
            itemCount: data.movies.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
