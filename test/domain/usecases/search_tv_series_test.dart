import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTVSeriesRepository);
  });

  final tTVSeries = <TvSeries>[];
  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVSeries));
  });
}
