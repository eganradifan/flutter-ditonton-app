import '../../../utils/state_enum.dart';
import '../../presentation/provider/tv_show/now_playing_tv_show_notifier.dart';
import '../../presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        Provider.of<NowPlayingTvShowNotifier>(context, listen: false)
            .fetchNowPlayingTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Shows'),
      ),
      body:
          Padding(padding: const EdgeInsets.all(8.0), child: _renderTvShows()),
    );
  }

  Widget _renderTvShows() {
    return Consumer<NowPlayingTvShowNotifier>(
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
}
