import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/tv_show_top_rated_bloc.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvShowTopRatedBloc
    extends MockBloc<TvShowTopRatedEvent, TvShowTopRatedState>
    implements TvShowTopRatedBloc {}

class TvShowTopRatedEventFake extends Fake implements TvShowTopRatedEvent {}

class TvShowTopRatedStateFake extends Fake implements TvShowTopRatedState {}

class MockMovieTopRatedBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class MovieTopRatedEventFake extends Fake implements MovieTopRatedEvent {}

class MovieTopRatedStateFake extends Fake implements MovieTopRatedState {}

void main() {
  late TvShowTopRatedBloc tvShowTopRatedBloc;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    tvShowTopRatedBloc = MockTvShowTopRatedBloc();
    movieTopRatedBloc = MockMovieTopRatedBloc();
  });

  setUpAll(() {
    registerFallbackValue(TvShowTopRatedEventFake());
    registerFallbackValue(TvShowTopRatedStateFake());
    registerFallbackValue(MovieTopRatedEventFake());
    registerFallbackValue(MovieTopRatedStateFake());
  });

  group('popular movie', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<MovieTopRatedBloc>.value(
        value: movieTopRatedBloc,
        child: MaterialApp(
          home: Scaffold(
              body: TopRatedMoviesPage(
            isTvShow: false,
          )),
        ),
      );
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => movieTopRatedBloc.state).thenReturn(MovieTopRatedLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => movieTopRatedBloc.state)
          .thenReturn(MovieTopRatedHasData(const <Movie>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => movieTopRatedBloc.state)
          .thenReturn(MovieTopRatedError("Error message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('popular tv show', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TvShowTopRatedBloc>.value(
        value: tvShowTopRatedBloc,
        child: MaterialApp(
          home: Scaffold(
              body: TopRatedMoviesPage(
            isTvShow: true,
          )),
        ),
      );
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvShowTopRatedBloc.state).thenReturn(TvShowTopRatedLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage(
        isTvShow: true,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => tvShowTopRatedBloc.state)
          .thenReturn(TvShowTopRatedHasData(const <TvShow>[]));

      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(_makeTestableWidget(TopRatedMoviesPage(isTvShow: true)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => tvShowTopRatedBloc.state)
          .thenReturn(TvShowTopRatedError("Error Message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(_makeTestableWidget(TopRatedMoviesPage(isTvShow: true)));

      expect(textFinder, findsOneWidget);
    });
  });
}
