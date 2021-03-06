import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/tv_show/now_playing/tv_show_now_playing_bloc.dart';
import 'package:core/presentation/bloc/tv_show/popular/tv_show_popular_bloc.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/tv_show_top_rated_bloc.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv_show/tv_show.dart';
import '../../presentation/pages/now_playing_page.dart';
import '../../presentation/pages/popular_movies_page.dart';
import '../../presentation/pages/top_rated_movies_page.dart';
import '../../presentation/pages/tv_show_detail_page.dart';
import '../../presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class TvShowListPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-shows-list';

  @override
  _TvShowListPageState createState() => _TvShowListPageState();
}

class _TvShowListPageState extends State<TvShowListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          BlocProvider.of<TvShowTopRatedBloc>(context, listen: false)
              .add(FetchTopRatedTvShows())
        });
    Future.microtask(() => {
          BlocProvider.of<TvShowNowPlayingBloc>(context, listen: false)
              .add(FetchNowPlayingTvShows())
        });
    Future.microtask(() => {
          BlocProvider.of<TvShowPopularBloc>(context, listen: false)
              .add(FetchPopularTvShows())
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Movies'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.tv),
                title: const Text('Tv Show'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Watchlist'),
                onTap: () {
                  Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ABOUT_ROUTE);
                },
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Ditonton TV Shows'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SEARCH_ROUTE, arguments: true);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () => Navigator.pushNamed(
                      context, NowPlayingPage.ROUTE_NAME,
                      arguments: true),
                ),
                BlocBuilder<TvShowNowPlayingBloc, TvShowNowPlayingState>(
                    builder: (context, state) {
                  if (state is TvShowNowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvShowNowPlayingHasData) {
                    return TvShowList(state.result);
                  } else if (state is TvShowNowPlayingError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                }),
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(
                      context, PopularMoviesPage.ROUTE_NAME,
                      arguments: true),
                ),
                BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
                    builder: (context, state) {
                  if (state is TvShowPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvShowPopularHasData) {
                    return TvShowList(state.result);
                  } else if (state is TvShowPopularError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                }),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () => Navigator.pushNamed(
                      context, TopRatedMoviesPage.ROUTE_NAME,
                      arguments: true),
                ),
                BlocBuilder<TvShowTopRatedBloc, TvShowTopRatedState>(
                    builder: (context, state) {
                  if (state is TvShowTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvShowTopRatedHasData) {
                    return TvShowList(state.result);
                  } else if (state is TvShowTopRatedError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ));
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
