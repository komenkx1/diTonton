import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

import '../../helpers/tv_series_page_helper.dart';

void main() {
  late FakeDetailTVSeriesBloc fakeDetailTVSeriesBloc;
  late FakeTVSeriesRecommendationsBloc fakeTVSeriesRecommendationsBloc;
  late FakeWatchlistTVSeriesBloc fakeWatchlistTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeTVSeriesDetailEvent());
    registerFallbackValue(FakeTVSeriesDetailState());
    fakeDetailTVSeriesBloc = FakeDetailTVSeriesBloc();

    registerFallbackValue(FakeTVSeriesRecommendationsEvent());
    registerFallbackValue(FakeTVSeriesRecommendationsState());
    fakeTVSeriesRecommendationsBloc = FakeTVSeriesRecommendationsBloc();

    registerFallbackValue(FakeWatchlistTvSeriesEvent());
    registerFallbackValue(FakeWatchlistTvSeriesState());
    fakeWatchlistTVSeriesBloc = FakeWatchlistTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvSeriesBloc>(
          create: (_) => fakeDetailTVSeriesBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => fakeWatchlistTVSeriesBloc,
        ),
        BlocProvider<RecommendationTvSeriesBloc>(
          create: (_) => fakeTVSeriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailTVSeriesBloc.close();
    fakeWatchlistTVSeriesBloc.close();
    fakeTVSeriesRecommendationsBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTvSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTvSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTvSeriesLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());

    final viewProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(viewProgress, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTvSeriesHasData(testTvSeriesDetailResponseEntity));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTvSeriesHasData(testTvSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(InsertDataTvSeriesToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(DetailTvSeriesHasData(testTvSeriesDetailResponseEntity));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationTvSeriesHasData(testTvSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(InsertDataTvSeriesToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect((watchlistButton), findsOneWidget);
  });
}
