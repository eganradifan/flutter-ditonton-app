import 'package:ditonton/data/models/tv_show/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  final tvShowResponse = {
    "page": 1,
    "results": [
      {
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
      }
    ],
    "total_pages": 1,
    "total_results": 1,
  };

  final tvShowResponseObject = TvShowResponse(
      page: 1, totalPages: 1, totalResults: 1, results: [tvShowModel]);

  test("should convert json to TvShowResponse", () async {
    final result = TvShowResponse.fromJson(tvShowResponse);
    expect(result, tvShowResponseObject);
  });

  test("should convert TvShowResponse to json", () async {
    final result = tvShowResponseObject.toJson();
    expect(result, tvShowResponse);
  });
}
