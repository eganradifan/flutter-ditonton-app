import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_show/tv_show.dart';
import '../../domain/entities/tv_show/tv_show_detail.dart';
import '../../presentation/provider/tv_show/tv_show_detail_notifier.dart';
import '../../presentation/widgets/detail_back_button.dart';
import '../../presentation/widgets/recommendations_poster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .fetchTvShowDetail(widget.id);
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == RequestState.Loaded) {
            final tvShow = provider.tvShows;
            return SafeArea(
              child: DetailContent(
                tvShow,
                provider.tvShowsRecommendation,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvShow;
  final List<TvShow> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvShow, this.recommendations, this.isAddedWatchlist);

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
                decoration: BoxDecoration(
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
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvShowDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(tvShow);
                                } else {
                                  await Provider.of<TvShowDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(tvShow);
                                }

                                final message =
                                    Provider.of<TvShowDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        TvShowDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvShowDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
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
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
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
                            SizedBox(height: 8),
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
                            SizedBox(height: 8),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            SizedBox(height: 16),
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
        DetailBackButton()
      ],
    );
  }

  Widget _renderTvShowsRecommendations() {
    return Consumer<TvShowDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.Error) {
          return Text(data.message);
        } else if (data.recommendationState == RequestState.Loaded) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvShow = recommendations[index];
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
              itemCount: recommendations.length,
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
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
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
