import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/tv_show_top_rated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/state_enum.dart';
import '../../presentation/provider/movie/top_rated_movies_notifier.dart';
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
          BlocProvider.of<TvShowTopRatedBloc>(context, listen: false)
              .add(FetchTopRatedTvShows()));
    } else {
      Future.microtask(() =>
          BlocProvider.of<MovieTopRatedBloc>(context, listen: false)
              .add(FetchTopRatedMovies()));
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
    return BlocBuilder<TvShowTopRatedBloc, TvShowTopRatedState>(
      builder: (context, state) {
        if (state is TvShowTopRatedLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvShowTopRatedHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.result[index];
              return TvShowCard(movie);
            },
            itemCount: state.result.length,
          );
        } else if (state is TvShowTopRatedError) {
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
    return BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
      builder: (context, state) {
        if (state is MovieTopRatedLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieTopRatedHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.result[index];
              return MovieCard(movie);
            },
            itemCount: state.result.length,
          );
        } else if (state is MovieTopRatedError) {
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
}
