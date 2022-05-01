import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/movie/now_playing/movie_now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie/popular/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../styles/text_styles.dart';
import '../../utils/constants.dart';
import '../../domain/entities/movies/movie.dart';
import 'package:core/utils/routes.dart';
import './movie_detail_page.dart';
import './popular_movies_page.dart';
import './top_rated_movies_page.dart';
import './tv_show_list_page.dart';
import './watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<MovieNowPlayingBloc>(context, listen: false)
            .add(FetchNowPlayingMovies()));
    Future.microtask(() =>
        BlocProvider.of<MoviePopularBloc>(context, listen: false)
            .add(FetchPopularMovies()));
    Future.microtask(() =>
        BlocProvider.of<MovieTopRatedBloc>(context, listen: false)
            .add(FetchTopRatedMovies()));
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Show'),
              onTap: () {
                Navigator.pushNamed(context, TvShowListPage.ROUTE_NAME);
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
        title: const Text('Ditonton Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE, arguments: false);
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
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                if (state is MovieNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieNowPlayingHasData) {
                  return MovieList(state.result);
                } else if (state is MovieNowPlayingError) {
                  return const Text('Failed');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularMoviesPage.ROUTE_NAME,
                    arguments: false),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                if (state is MoviePopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviePopularHasData) {
                  return MovieList(state.result);
                } else if (state is MoviePopularError) {
                  return const Text('Failed');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedMoviesPage.ROUTE_NAME,
                    arguments: false),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                if (state is MovieTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieTopRatedHasData) {
                  return MovieList(state.result);
                } else if (state is MovieTopRatedError) {
                  return const Text('Failed');
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
