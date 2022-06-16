import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchTVSeriesBloc;
  late MockSearchTvSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTvSeries();
    searchTVSeriesBloc = SearchTvSeriesBloc(mockSearchTVSeries);
  });

  test('initial state should be empty', () {
    expect(searchTVSeriesBloc.state, SearchTvSeriesEmpty());
  });

  final tTVSeriesModel = TvSeries(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );

  final tTVSeriesList = <TvSeries>[tTVSeriesModel];
  final tQuery = 'spiderman';

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTvSeries(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTvSeries(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}
