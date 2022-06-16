import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTVSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTVSeriesRepository.removeWatchlist(testTvSeriesDetailEntity))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetailEntity);
    // assert
    verify(mockTVSeriesRepository.removeWatchlist(testTvSeriesDetailEntity));
    expect(result, Right('Removed from watchlist'));
  });
}
