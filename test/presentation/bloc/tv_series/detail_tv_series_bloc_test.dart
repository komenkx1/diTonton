import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_series/tv_series_detail_notifier_test.mocks.dart';

void main() {
  late DetailTvSeriesBloc detailTVSeriesBloc;
  late MockGetTvSeriesDetail mockGetTVSeriesDetail;

  const tId = 1;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTvSeriesDetail();
    detailTVSeriesBloc = DetailTvSeriesBloc(mockGetTVSeriesDetail);
  });

  group('detail TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(detailTVSeriesBloc.state, DetailTvSeriesEmpty());
    });

    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetailEntity));
        return detailTVSeriesBloc;
      },
      act: (bloc) => bloc.add(DetailTvSeriesAppellation(tId)),
      expect: () => [
        DetailTvSeriesLoading(),
        DetailTvSeriesHasData(testTvSeriesDetailEntity),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
        return DetailTvSeriesAppellation(tId).props;
      },
    );

    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailTVSeriesBloc;
      },
      act: (bloc) => bloc.add(DetailTvSeriesAppellation(tId)),
      expect: () => [
        DetailTvSeriesLoading(),
        DetailTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => DetailTvSeriesLoading(),
    );
  });
}
