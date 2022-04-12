import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movies/movie_table.dart';
import 'package:core/data/models/tv_show/created_by.dart';
import 'package:core/data/models/tv_show/tv_show_detail.dart';
import 'package:core/data/models/tv_show/tv_show_model.dart';
import 'package:core/data/models/tv_show/tv_show_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/domain/entities/tv_show/tv_show_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];
final testTvShowList = [tvShow];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowTable = TvShowTable(
  id: 1668,
  title: 'Friends',
  overview:
      "Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.",
  posterPath: "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
);

final testWatchlisTvShow = TvShow.watchlist(
  id: 1668,
  name: 'Friends',
  overview:
      "Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.",
  posterPath: "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvshowMap = {
  'id': 1668,
  'title': 'Friends',
  'overview':
      "Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.",
  'posterPath': "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
};

final tvShowModel = TvShowModel(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 0123,
    name: "new show",
    originCountry: ["England"],
    originalLanguage: "English",
    originalName: "new show",
    overview: "good",
    popularity: 9,
    posterPath: 'posterPath',
    voteAverage: 9,
    voteCount: 99);

final tvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 0123,
    name: "new show",
    originCountry: ["England"],
    originalLanguage: "English",
    originalName: "new show",
    overview: "good",
    popularity: 9,
    posterPath: 'posterPath',
    voteAverage: 9,
    voteCount: 99);

final tvShowDetailEntity = TvShowDetail(
    adult: false,
    backdropPath: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg",
    createdBy: [
      CreatedBy(
        id: 163461,
        creditId: "525710bf19c295731c03280b",
        name: "Marta Kauffman",
        gender: 1,
        profilePath: "/AsX4ZOoQP5oQVLiA51zdRiTNKTm.jpg",
      ),
      CreatedBy(
        id: 1216352,
        creditId: "525710bf19c295731c032811",
        name: "David Crane",
        gender: 2,
        profilePath: "/1NYo5ZYCSqoxQ5sqXLMDm3cqvKp.jpg",
      )
    ],
    episodeRunTime: [25],
    firstAirDate: "1994-09-22",
    genres: [
      Genre(id: 35, name: "Comedy"),
      Genre(id: 18, name: "Drama"),
    ],
    id: 1668,
    languages: ["en"],
    lastAirDate: "2004-05-06",
    name: "Friends",
    numberOfEpisodes: 236,
    numberOfSeasons: 10,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Friends",
    overview:
        "Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.",
    popularity: 343.676,
    posterPath: "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
    voteAverage: 8.5,
    voteCount: 5541);

final tvShowDetailModel = TvShowDetailModel(
    adult: false,
    backdropPath: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg",
    createdBy: [
      CreatedBy(
        id: 163461,
        creditId: "525710bf19c295731c03280b",
        name: "Marta Kauffman",
        gender: 1,
        profilePath: "/AsX4ZOoQP5oQVLiA51zdRiTNKTm.jpg",
      ),
      CreatedBy(
        id: 1216352,
        creditId: "525710bf19c295731c032811",
        name: "David Crane",
        gender: 2,
        profilePath: "/1NYo5ZYCSqoxQ5sqXLMDm3cqvKp.jpg",
      )
    ],
    episodeRunTime: [25],
    firstAirDate: "1994-09-22",
    genres: [
      GenreModel(id: 35, name: "Comedy"),
      GenreModel(id: 18, name: "Drama"),
    ],
    homepage: "https://www.netflix.com/title/70153404",
    id: 1668,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2004-05-06",
    name: "Friends",
    numberOfEpisodes: 236,
    numberOfSeasons: 10,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Friends",
    overview:
        "Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.",
    popularity: 343.676,
    posterPath: "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
    productionCompanies: [
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
    productionCountries: [
      {"iso_3166_1": "US", "name": "United States of America"}
    ],
    status: "Ended",
    tagline: "I'll be there for you",
    type: "Scripted",
    voteAverage: 8.5,
    voteCount: 5541);
