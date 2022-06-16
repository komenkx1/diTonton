import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_watchlist_notifier_test.mocks.dart';

void main() {
  late WatchlistTvSeriesBloc watchlistTVSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTVSeries;
  late MockGetWatchListStatusTvSeries mockGetDataTVSeriesWatchListStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTVSeries;
  late MockDeleteWatchlistTvSeries mockDeleteWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTvSeries();
    mockGetDataTVSeriesWatchListStatus = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTVSeries = MockSaveWatchlistTvSeries();
    mockDeleteWatchlistTvSeries = MockDeleteWatchlistTvSeries();
    watchlistTVSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchlistTVSeries,
      mockGetDataTVSeriesWatchListStatus,
      mockSaveWatchlistTVSeries,
      mockDeleteWatchlistTvSeries,
    );
  });

  group('watchlist TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistTVSeriesBloc.state, WatchlistTvSeriesEmpty());
    });

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGotWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesHasData(testTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
        return OnGotWatchlistTvSeries().props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGotWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvSeriesLoading(),
    );
  });

  group('status watchlist TV Series bloc test', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetDataTVSeriesWatchListStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);

        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(GotWatchlistTvSeries(testTvSeriesDetail.id)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        InsertDataTvSeriesToWatchlist(false),
      ],
      verify: (bloc) => WatchlistTvSeriesLoading(),
    );
  });

  group('add watchlist TV Series bloc test', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockSaveWatchlistTVSeries.execute(testTvSeriesDetailEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(InsertWatchlistTvSeries(testTvSeriesDetailEntity)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistTvSeries(testTvSeriesDetailEntity),
    );
  });

  group('delete watchlist TV Series bloc test', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetailEntity))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(DeleteWatchlistTvSeries(testTvSeriesDetailEntity)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        MessageTvSeriesWatchlist('Delete to Watchlist'),
        InsertDataTvSeriesToWatchlist(false)
      ],
      verify: (bloc) {
        verify(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetailEntity));
        return DeleteWatchlistTvSeries(testTvSeriesDetailEntity).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetailEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(DeleteWatchlistTvSeries(testTvSeriesDetailEntity)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistTvSeries(testTvSeriesDetailEntity),
    );
  });
}
