import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTVSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTVSeriesRepository.saveWatchlist(testTvSeriesDetailEntity))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetailEntity);
    // assert
    verify(mockTVSeriesRepository.saveWatchlist(testTvSeriesDetailEntity));
    expect(result, Right('Added to Watchlist'));
  });
}
