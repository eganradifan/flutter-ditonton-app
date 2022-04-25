import 'package:core/presentation/bloc/tv_show/popular/tv_show_popular_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/state_enum.dart';
import '../../presentation/provider/movie/popular_movies_notifier.dart';
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
          BlocProvider.of<TvShowPopularBloc>(context, listen: false)
              .add(FetchPopularTvShows()));
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
        title: const Text('Popular Movies'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.isTvShow ? _renderTvShows() : _renderMovies()),
    );
  }

  Widget _renderTvShows() {
    return BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
      builder: (context, state) {
        if (state is TvShowPopularLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvShowPopularHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvShow = state.result[index];
              return TvShowCard(tvShow);
            },
            itemCount: state.result.length,
          );
        } else if (state is TvShowPopularError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _renderMovies() {
    return Consumer<PopularMoviesNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return const Center(
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
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
