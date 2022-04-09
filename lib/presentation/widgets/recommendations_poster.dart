import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecommendationsPoster extends StatelessWidget {
  const RecommendationsPoster({Key? key, this.posterPath}) : super(key: key);
  final String? posterPath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      child: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
