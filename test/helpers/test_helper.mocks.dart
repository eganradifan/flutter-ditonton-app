// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i24;
import 'dart:typed_data' as _i25;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i8;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i22;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i20;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i18;
import 'package:ditonton/data/datasources/tv_local_data_source.dart' as _i13;
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart'
    as _i11;
import 'package:ditonton/data/models/movies/movie_detail_model.dart' as _i4;
import 'package:ditonton/data/models/movies/movie_model.dart' as _i19;
import 'package:ditonton/data/models/movies/movie_table.dart' as _i21;
import 'package:ditonton/data/models/tv_show/tv_show_detail.dart' as _i3;
import 'package:ditonton/data/models/tv_show/tv_show_model.dart' as _i12;
import 'package:ditonton/data/models/tv_show/tv_show_table.dart' as _i14;
import 'package:ditonton/domain/entities/movies/movie.dart' as _i16;
import 'package:ditonton/domain/entities/movies/movie_detail.dart' as _i17;
import 'package:ditonton/domain/entities/tv_show/tv_show.dart' as _i9;
import 'package:ditonton/domain/entities/tv_show/tv_show_detail.dart' as _i10;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i15;
import 'package:ditonton/domain/repositories/tv_show_repository.dart' as _i6;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i23;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTvShowDetailModel_1 extends _i1.Fake
    implements _i3.TvShowDetailModel {}

class _FakeMovieDetailResponse_2 extends _i1.Fake
    implements _i4.MovieDetailResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i6.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>> getNowPlayingTvShow() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvShow, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>> getPopularTvShow() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShow, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>> getTopRatedTvShow() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShow, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.TvShowDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.TvShowDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.TvShowDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.TvShowDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.TvShowDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>> getWatchlistTvShow() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShow, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i11.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.TvShowModel>> getNowPlayingTvShows() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
              returnValue:
                  Future<List<_i12.TvShowModel>>.value(<_i12.TvShowModel>[]))
          as _i7.Future<List<_i12.TvShowModel>>);
  @override
  _i7.Future<List<_i12.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i12.TvShowModel>>.value(<_i12.TvShowModel>[]))
          as _i7.Future<List<_i12.TvShowModel>>);
  @override
  _i7.Future<List<_i12.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i12.TvShowModel>>.value(<_i12.TvShowModel>[]))
          as _i7.Future<List<_i12.TvShowModel>>);
  @override
  _i7.Future<_i3.TvShowDetailModel> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i3.TvShowDetailModel>.value(
                  _FakeTvShowDetailModel_1()))
          as _i7.Future<_i3.TvShowDetailModel>);
  @override
  _i7.Future<List<_i12.TvShowModel>> getTvShowsRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowsRecommendations, [id]),
              returnValue:
                  Future<List<_i12.TvShowModel>>.value(<_i12.TvShowModel>[]))
          as _i7.Future<List<_i12.TvShowModel>>);
  @override
  _i7.Future<List<_i12.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i12.TvShowModel>>.value(<_i12.TvShowModel>[]))
          as _i7.Future<List<_i12.TvShowModel>>);
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i13.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i14.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i14.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i14.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i14.TvShowTable?>.value())
          as _i7.Future<_i14.TvShowTable?>);
  @override
  _i7.Future<List<_i14.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i14.TvShowTable>>.value(<_i14.TvShowTable>[]))
          as _i7.Future<List<_i14.TvShowTable>>);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i15.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i17.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i17.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i17.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i17.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i17.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i17.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i18.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i19.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i19.MovieModel>>.value(<_i19.MovieModel>[]))
          as _i7.Future<List<_i19.MovieModel>>);
  @override
  _i7.Future<List<_i19.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i19.MovieModel>>.value(<_i19.MovieModel>[]))
      as _i7.Future<List<_i19.MovieModel>>);
  @override
  _i7.Future<List<_i19.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i19.MovieModel>>.value(<_i19.MovieModel>[]))
      as _i7.Future<List<_i19.MovieModel>>);
  @override
  _i7.Future<_i4.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i4.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_2()))
          as _i7.Future<_i4.MovieDetailResponse>);
  @override
  _i7.Future<List<_i19.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i19.MovieModel>>.value(<_i19.MovieModel>[]))
          as _i7.Future<List<_i19.MovieModel>>);
  @override
  _i7.Future<List<_i19.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i19.MovieModel>>.value(<_i19.MovieModel>[]))
          as _i7.Future<List<_i19.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i20.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i21.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i21.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i21.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i21.MovieTable?>.value())
          as _i7.Future<_i21.MovieTable?>);
  @override
  _i7.Future<List<_i21.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i21.MovieTable>>.value(<_i21.MovieTable>[]))
      as _i7.Future<List<_i21.MovieTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i22.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i23.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i23.Database?>.value())
          as _i7.Future<_i23.Database?>);
  @override
  _i7.Future<int> insertMovieWatchlist(_i21.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeMovieWatchlist(_i21.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> insertTvShowWatchlist(_i14.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTvShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeTvShowWatchlist(_i14.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i25.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i25.Uint8List>.value(_i25.Uint8List(0)))
          as _i7.Future<_i25.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
