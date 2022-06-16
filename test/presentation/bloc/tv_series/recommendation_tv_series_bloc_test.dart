import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import 'package:ditonton/presentation/bloc/tv_series/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_detail_notifier_test.mocks.dart';

void main() {
  late RecommendationTvSeriesBloc recommendationTVSeriesBloc;
  late MockGetTvSeriesRecommendations mockGetRecommendationTVSeries;

  const tId = 1;

  setUp(() {
    mockGetRecommendationTVSeries = MockGetTvSeriesRecommendations();
    recommendationTVSeriesBloc =
        RecommendationTvSeriesBloc(mockGetRecommendationTVSeries);
  });

  group('recommendation TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(recommendationTVSeriesBloc.state, RecommendationTvSeriesEmpty());
    });

    blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationTVSeries.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesList));
        return recommendationTVSeriesBloc;
      },
      act: (bloc) => bloc.add(RecommendationTvSeriesAppellation(tId)),
      expect: () => [
        RecommendationTvSeriesLoading(),
        RecommendationTvSeriesHasData(testTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationTVSeries.execute(tId));
        return RecommendationTvSeriesAppellation(tId).props;
      },
    );

    blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetRecommendationTVSeries.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationTVSeriesBloc;
      },
      act: (bloc) => bloc.add(RecommendationTvSeriesAppellation(tId)),
      expect: () => [
        RecommendationTvSeriesLoading(),
        RecommendationTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => PopularTvSeriesLoading(),
    );
  });
}
