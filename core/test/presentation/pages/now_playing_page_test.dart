import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/presentation/bloc/tv_show/now_playing/tv_show_now_playing_bloc.dart';
import 'package:core/presentation/pages/now_playing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvShowNowPlayingBloc
    extends MockBloc<TvShowNowPlayingEvent, TvShowNowPlayingState>
    implements TvShowNowPlayingBloc {}

class TvShowNowPlayingEventFake extends Fake implements TvShowNowPlayingEvent {}

class TvShowNowPlayingStateFake extends Fake implements TvShowNowPlayingState {}

void main() {
  late TvShowNowPlayingBloc tvShowNowPlayingBloc;

  setUp(() {
    tvShowNowPlayingBloc = MockTvShowNowPlayingBloc();
  });

  setUpAll(() {
    registerFallbackValue(TvShowNowPlayingEventFake());
    registerFallbackValue(TvShowNowPlayingStateFake());
  });

  group('now playing tv show', () {
    Widget _makeTestableWidget() {
      return BlocProvider<TvShowNowPlayingBloc>.value(
        value: tvShowNowPlayingBloc,
        child: const MaterialApp(
          home: Scaffold(body: NowPlayingPage()),
        ),
      );
    }

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvShowNowPlayingBloc.state)
          .thenAnswer((_) => TvShowNowPlayingLoading());
      await tester.pumpWidget(_makeTestableWidget());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => tvShowNowPlayingBloc.state)
          .thenReturn(TvShowNowPlayingHasData(const <TvShow>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget());

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => tvShowNowPlayingBloc.state)
          .thenReturn(TvShowNowPlayingError("Error message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget());

      expect(textFinder, findsOneWidget);
    });
  });
}
