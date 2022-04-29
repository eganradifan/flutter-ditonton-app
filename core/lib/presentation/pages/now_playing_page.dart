import 'package:core/presentation/bloc/tv_show/now_playing/tv_show_now_playing_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';

class NowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing';
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TvShowNowPlayingBloc>(context, listen: false)
            .add(FetchNowPlayingTvShows()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Shows'),
      ),
      body:
          Padding(padding: const EdgeInsets.all(8.0), child: _renderTvShows()),
    );
  }

  Widget _renderTvShows() {
    return BlocBuilder<TvShowNowPlayingBloc, TvShowNowPlayingState>(
      builder: (context, state) {
        if (state is TvShowNowPlayingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvShowNowPlayingHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.result[index];
              return TvShowCard(movie);
            },
            itemCount: state.result.length,
          );
        } else if (state is TvShowNowPlayingError) {
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
