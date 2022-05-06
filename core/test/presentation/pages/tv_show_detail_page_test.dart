import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show/tv_show.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_watchlist_bloc.dart';
import 'package:core/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvShowDetailBloc
    extends MockBloc<TvShowDetailEvent, TvShowDetailState>
    implements TvShowDetailBloc {}

class TvShowDetailEventFake extends Fake implements TvShowDetailEvent {}

class TvShowDetailStateFake extends Fake implements TvShowDetailState {}

class MockTvShowDetailRecommendationBloc extends MockBloc<
        TvShowDetailRecommendationEvent, TvShowDetailRecommendationState>
    implements TvShowDetailRecommendationBloc {}

class TvShowDetailRecommendationEventFake extends Fake
    implements TvShowDetailRecommendationEvent {}

class TvShowDetailRecommendationStateFake extends Fake
    implements TvShowDetailRecommendationState {}

class MockTvShowDetailWatchlistBloc
    extends MockBloc<TvShowDetailWatchlistEvent, TvShowDetailWatchlistState>
    implements TvShowDetailWatchlistBloc {}

class TvShowDetailWatchlistEventFake extends Fake
    implements TvShowDetailWatchlistEvent {}

class TvShowDetailWatchlistStateFake extends Fake
    implements TvShowDetailWatchlistState {}

void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late TvShowDetailRecommendationBloc tvShowDetailRecommendationBloc;
  late TvShowDetailWatchlistBloc tvShowDetailWatchlistBloc;

  setUp(() {
    tvShowDetailBloc = MockTvShowDetailBloc();
    tvShowDetailRecommendationBloc = MockTvShowDetailRecommendationBloc();
    tvShowDetailWatchlistBloc = MockTvShowDetailWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvShowDetailBloc>.value(
          value: tvShowDetailBloc,
        ),
        BlocProvider<TvShowDetailRecommendationBloc>.value(
          value: tvShowDetailRecommendationBloc,
        ),
        BlocProvider<TvShowDetailWatchlistBloc>.value(
          value: tvShowDetailWatchlistBloc,
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
    when(() => tvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(tvShowDetailEntity));
    when(() => tvShowDetailRecommendationBloc.state)
        .thenReturn(TvShowDetailRecommendationHasData(const <TvShow>[]));
    when(() => tvShowDetailWatchlistBloc.state)
        .thenReturn(TvShowWatchlistStatusLoaded(false));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1668)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => tvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(tvShowDetailEntity));
    when(() => tvShowDetailRecommendationBloc.state)
        .thenReturn(TvShowDetailRecommendationHasData(const <TvShow>[]));
    when(() => tvShowDetailWatchlistBloc.state)
        .thenReturn(TvShowWatchlistStatusLoaded(true));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1668)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
