import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import '../provider/movie/movie_search_notifier.dart';
import '../provider/tv_show/tv_show_search_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final bool isTvShow;
  SearchPage({required this.isTvShow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (isTvShow) {
                  Provider.of<TvShowsSearchNotifier>(context, listen: false)
                      .fetchTvShowsSearch(query);
                } else {
                  context.read<SearchBloc>().add(OnQueryChanged(query));
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isTvShow ? _renderTvShowsResult() : _renderMovieResult(),
          ],
        ),
      ),
    );
  }

  Widget _renderMovieResult() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }

  Widget _renderTvShowsResult() {
    return Consumer<TvShowsSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.tvShows;
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvShows = data.tvShows[index];
                return TvShowCard(tvShows);
              },
              itemCount: result.length,
            ),
          );
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
