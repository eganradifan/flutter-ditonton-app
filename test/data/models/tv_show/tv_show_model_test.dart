import 'package:ditonton/data/models/tv_show/tv_show_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  final tvResponse = {
    "backdrop_path": 'backdropPath',
    "first_air_date": '2022-01-01',
    "genre_ids": [1, 2, 3],
    "id": 0123,
    "name": "new show",
    "origin_country": ["England"],
    "original_language": "English",
    "original_name": "new show",
    "overview": "good",
    "popularity": 9,
    "poster_path": 'posterPath',
    "vote_average": 9,
    "vote_count": 99
  };

  test("should convert json to TvShowModel", () async {
    final result = TvShowModel.fromJson(tvResponse);
    expect(result, tvShowModel);
  });
  test("should be a subclass of Tv Show entity", () async {
    final result = tvShowModel.toEntity();
    expect(result, tvShow);
  });

  test("should convert TvShowModel to json", () async {
    final result = tvShowModel.toJson();
    expect(result, tvResponse);
  });
}
