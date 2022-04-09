import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movies/movie.dart';
import 'package:ditonton/domain/entities/tv_show/tv_show.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesNotifier, TopRatedTvShowsNotifier])
void main() {
  late MockTopRatedMoviesNotifier mockNotifier;
  late MockTopRatedTvShowsNotifier mockTopRatedTvShowsNotifier;

  setUp(() {
    mockNotifier = MockTopRatedMoviesNotifier();
    mockTopRatedTvShowsNotifier = MockTopRatedTvShowsNotifier();
  });

  group('movies', () {
    Widget _makeTestableWidget(Widget body) {
      return ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
        value: mockNotifier,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.movies).thenReturn(<Movie>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('tv show', () {
    Widget _makeTestableWidget(Widget body) {
      return ChangeNotifierProvider<TopRatedTvShowsNotifier>.value(
        value: mockTopRatedTvShowsNotifier,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockTopRatedTvShowsNotifier.state).thenReturn(RequestState.Loading);

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage(
        isTvShow: true,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockTopRatedTvShowsNotifier.state).thenReturn(RequestState.Loaded);
      when(mockTopRatedTvShowsNotifier.tvShows).thenReturn(<TvShow>[]);

      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(_makeTestableWidget(TopRatedMoviesPage(isTvShow: true)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTopRatedTvShowsNotifier.state).thenReturn(RequestState.Error);
      when(mockTopRatedTvShowsNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester
          .pumpWidget(_makeTestableWidget(TopRatedMoviesPage(isTvShow: true)));

      expect(textFinder, findsOneWidget);
    });
  });
}
