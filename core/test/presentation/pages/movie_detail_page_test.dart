import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_watchlist_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieDetailRecommendationBloc extends MockBloc<
    MovieDetailRecommendationEvent,
    MovieDetailRecommendationState> implements MovieDetailRecommendationBloc {}

class MovieDetailRecommendationEventFake extends Fake
    implements MovieDetailRecommendationEvent {}

class MovieDetailRecommendationStateFake extends Fake
    implements MovieDetailRecommendationState {}

class MockMovieDetailWatchlistBloc
    extends MockBloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState>
    implements MovieDetailWatchlistBloc {}

class MovieDetailWatchlistEventFake extends Fake
    implements MovieDetailWatchlistEvent {}

class MovieDetailWatchlistStateFake extends Fake
    implements MovieDetailWatchlistState {}

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MovieDetailRecommendationBloc movieDetailRecommendationBloc;
  late MovieDetailWatchlistBloc movieDetailWatchlistBloc;

  setUp(() {
    movieDetailBloc = MockMovieDetailBloc();
    movieDetailRecommendationBloc = MockMovieDetailRecommendationBloc();
    movieDetailWatchlistBloc = MockMovieDetailWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(
          value: movieDetailBloc,
        ),
        BlocProvider<MovieDetailRecommendationBloc>.value(
          value: movieDetailRecommendationBloc,
        ),
        BlocProvider<MovieDetailWatchlistBloc>.value(
          value: movieDetailWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => movieDetailRecommendationBloc.state)
        .thenReturn(MovieDetailRecommendationHasData(const <Movie>[]));
    when(() => movieDetailWatchlistBloc.state)
        .thenReturn(MovieWatchlistStatusLoaded(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => movieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => movieDetailRecommendationBloc.state)
        .thenReturn(MovieDetailRecommendationHasData(const <Movie>[]));
    when(() => movieDetailWatchlistBloc.state)
        .thenReturn(MovieWatchlistStatusLoaded(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
