import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_show/tv_show_detail.dart';
import '../../presentation/widgets/detail_back_button.dart';
import '../../presentation/widgets/recommendations_poster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show-detail';
  final int id;
  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvShowDetailBloc>(context, listen: false)
          .add(FetchTvShowDetail(widget.id));
      BlocProvider.of<TvShowDetailRecommendationBloc>(context, listen: false)
          .add(FetchTvShowRecommendation(widget.id));
      BlocProvider.of<TvShowDetailWatchlistBloc>(context, listen: false)
          .add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
        builder: (context, state) {
          if (state is TvShowDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvShowDetailHasData) {
            final tvShow = state.result;
            return SafeArea(
              child: TvShowDetailContent(
                tvShow,
              ),
            );
          } else if (state is TvShowDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class TvShowDetailContent extends StatelessWidget {
  final TvShowDetail tvShow;

  TvShowDetailContent(this.tvShow);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        _renderPoster(tvShow.posterPath ?? "", screenWidth),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShow.name,
                              style: kHeading5,
                            ),
                            _renderWatchlistButton(),
                            Text(
                              _showGenres(tvShow.genres),
                            ),
                            Text(
                              tvShow.episodeRunTime.isNotEmpty
                                  ? _showDuration(tvShow.episodeRunTime[0])
                                  : "-",
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  'Number of Seasons: ',
                                  style: kHeading6,
                                ),
                                Text(
                                  tvShow.numberOfSeasons.toString(),
                                  style: kHeading6,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Number of Episodes: ',
                                  style: kHeading6,
                                ),
                                Text(
                                  tvShow.numberOfEpisodes.toString(),
                                  style: kHeading6,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _renderTvShowsRecommendations()
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        const DetailBackButton()
      ],
    );
  }

  Widget _renderWatchlistButton() {
    return BlocConsumer<TvShowDetailWatchlistBloc, TvShowDetailWatchlistState>(
        listener: (context, state) {
      if (state is TvShowDetailWatchlistActionError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.message),
              );
            });
      } else if (state is TvShowDetailWatchlistActionSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (context, state) {
      if (state is TvShowWatchlistStatusLoaded) {
        return ElevatedButton(
            onPressed: () async {
              if (!state.status) {
                BlocProvider.of<TvShowDetailWatchlistBloc>(context,
                        listen: false)
                    .add(AddWatchlist(tvShow));
              } else {
                BlocProvider.of<TvShowDetailWatchlistBloc>(context,
                        listen: false)
                    .add(RemoveFromWatchlist(tvShow));
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                state.status ? const Icon(Icons.check) : const Icon(Icons.add),
                const Text('Watchlist'),
              ],
            ));
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget _renderTvShowsRecommendations() {
    return BlocBuilder<TvShowDetailRecommendationBloc,
        TvShowDetailRecommendationState>(
      builder: (context, state) {
        if (state is TvShowDetailRecommendationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvShowDetailRecommendationError) {
          return Text(state.message);
        } else if (state is TvShowDetailRecommendationHasData) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvShow = state.result[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          TvShowDetailPage.ROUTE_NAME,
                          arguments: tvShow.id,
                        );
                      },
                      child:
                          RecommendationsPoster(posterPath: tvShow.posterPath)),
                );
              },
              itemCount: state.result.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _renderPoster(String posterPath, double screenWidth) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
      width: screenWidth,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
