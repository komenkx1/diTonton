import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/top_rated_tv_series_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_list_notifier_test.mocks.dart';

void main() {
  late TopRatedTvSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTvSeries();
    topRatedTVSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTVSeries);
  });

  group('top rated TVSeries bloc test', () {
    test('initial state should be empty', () {
      expect(topRatedTVSeriesBloc.state, TopRatedTvSeriesEmpty());
    });

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvSeriesAppellation()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesHasData(testTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
        return TopRatedTvSeriesAppellation().props;
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvSeriesAppellation()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => TopRatedTvSeriesLoading(),
    );
  });
}
