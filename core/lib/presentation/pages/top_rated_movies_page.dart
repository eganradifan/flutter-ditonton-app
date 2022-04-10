import '../../../utils/state_enum.dart';
import '../../presentation/provider/movie/top_rated_movies_notifier.dart';
import '../../presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import '../../presentation/widgets/movie_card_list.dart';
import '../../presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';
  final bool isTvShow;
  TopRatedMoviesPage({this.isTvShow = false});
  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    if (widget.isTvShow) {
      Future.microtask(() =>
          Provider.of<TopRatedTvShowsNotifier>(context, listen: false)
              .fetchTopRatedTvShows());
    } else {
      Future.microtask(() =>
          Provider.of<TopRatedMoviesNotifier>(context, listen: false)
              .fetchTopRatedMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated ${widget.isTvShow ? 'Tv Shows' : 'Movies'}'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.isTvShow ? _renderTvShows() : _renderMovies()),
    );
  }

  Widget _renderTvShows() {
    return Consumer<TopRatedTvShowsNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.tvShows[index];
              return TvShowCard(movie);
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
    return Consumer<TopRatedMoviesNotifier>(
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
