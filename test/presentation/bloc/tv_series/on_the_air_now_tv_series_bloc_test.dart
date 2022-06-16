import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_list_notifier_test.mocks.dart';

void main() {
  late NowPlayingTvSeriesBloc nowPlayingTVSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTvSeries();
    nowPlayingTVSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTVSeries);
  });

  group('on the air now TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(nowPlayingTVSeriesBloc.state, NowPlayingTvSeriesEmpty());
    });

    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return nowPlayingTVSeriesBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvSeriesAppellation()),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesHasData(testTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
        return NowPlayingTvSeriesAppellation().props;
      },
    );

    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingTVSeriesBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvSeriesAppellation()),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingTvSeriesLoading(),
    );
  });
}
