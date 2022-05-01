import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/presentation/bloc/movie/popular/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/tv_show/popular/tv_show_popular_bloc.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvShowPopularBloc
    extends MockBloc<TvShowPopularEvent, TvShowPopularState>
    implements TvShowPopularBloc {}

class TvShowPopularEventFake extends Fake implements TvShowPopularEvent {}

class TvShowPopularStateFake extends Fake implements TvShowPopularState {}

class MockMoviePopularBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class MoviePopularEventFake extends Fake implements MoviePopularEvent {}

class MoviePopularStateFake extends Fake implements MoviePopularState {}

void main() {
  late TvShowPopularBloc tvShowPopularBloc;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    tvShowPopularBloc = MockTvShowPopularBloc();
    moviePopularBloc = MockMoviePopularBloc();
  });

  setUpAll(() {
    registerFallbackValue(TvShowPopularEventFake());
    registerFallbackValue(TvShowPopularStateFake());
    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
  });

  group('popular movie', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<MoviePopularBloc>.value(
        value: moviePopularBloc,
        child: MaterialApp(
          home: Scaffold(
              body: PopularMoviesPage(
            isTvShow: false,
          )),
        ),
      );
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state).thenReturn(MoviePopularLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state)
          .thenReturn(MoviePopularHasData(const <Movie>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state)
          .thenReturn(MoviePopularError("Error message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('popular tv show', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TvShowPopularBloc>.value(
        value: tvShowPopularBloc,
        child: MaterialApp(
          home: Scaffold(
              body: PopularMoviesPage(
            isTvShow: true,
          )),
        ),
      );
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvShowPopularBloc.state).thenReturn(TvShowPopularLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage(
        isTvShow: true,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => tvShowPopularBloc.state)
          .thenReturn(TvShowPopularHasData(const <TvShow>[]));

      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(_makeTestableWidget(PopularMoviesPage(isTvShow: true)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => tvShowPopularBloc.state)
          .thenReturn(TvShowPopularError("Error Message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(_makeTestableWidget(PopularMoviesPage(isTvShow: true)));

      expect(textFinder, findsOneWidget);
    });
  });
}
