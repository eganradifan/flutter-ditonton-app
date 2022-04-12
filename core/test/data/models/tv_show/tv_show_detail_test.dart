import 'dart:convert';

import 'package:core/data/models/tv_show/tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../json_reader.dart';

void main() {
  final toJsonMock = {
    "adult": false,
    "backdrop_path": "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg",
    "created_by": [
      {
        "id": 163461,
        "credit_id": "525710bf19c295731c03280b",
        "name": "Marta Kauffman",
        "gender": 1,
        "profile_path": "/AsX4ZOoQP5oQVLiA51zdRiTNKTm.jpg"
      },
      {
        "id": 1216352,
        "credit_id": "525710bf19c295731c032811",
        "name": "David Crane",
        "gender": 2,
        "profile_path": "/1NYo5ZYCSqoxQ5sqXLMDm3cqvKp.jpg"
      }
    ],
    "episode_run_time": [25],
    "first_air_date": "1994-09-22",
    "genres": [
      {"id": 35, "name": "Comedy"},
      {"id": 18, "name": "Drama"}
    ],
    "homepage": "https://www.netflix.com/title/70153404",
    "id": 1668,
    "in_production": false,
    "languages": ["en"],
    "last_air_date": "2004-05-06",
    "name": "Friends",
    "number_of_episodes": 236,
    "number_of_seasons": 10,
    "origin_country": ["US"],
    "original_language": "en",
    "original_name": "Friends",
    "overview":
        "Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.",
    "popularity": 343.676,
    "poster_path": "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
    "production_companies": [
      {
        "id": 1957,
        "logo_path": "/3T19XSr6yqaLNK8uJWFImPgRax0.png",
        "name": "Warner Bros. Television",
        "origin_country": "US"
      },
      {
        "id": 31810,
        "logo_path": "/3oyBCnFO3tIRmny3yzYQpF5n2cS.png",
        "name": "Bright/Kauffman/Crane Productions",
        "origin_country": "US"
      }
    ],
    "production_countries": [
      {"iso_3166_1": "US", "name": "United States of America"}
    ],
    "status": "Ended",
    "tagline": "I'll be there for you",
    "type": "Scripted",
    "vote_average": 8.5,
    "vote_count": 5541
  };

  test("should return a valid model from JSON", () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_show_detail.json'));
    final modelFromJSon = TvShowDetailModel.fromJson(jsonMap);
    expect(modelFromJSon, tvShowDetailModel);
  });

  test("should return a valid JSON from Model", () async {
    final toJson = tvShowDetailModel.toJson();
    expect(toJson, toJsonMock);
  });
  test("should return a valid Detail Model to Entity", () async {
    final toEntity = tvShowDetailModel.toEntity();
    expect(toEntity, tvShowDetailEntity);
  });
}
