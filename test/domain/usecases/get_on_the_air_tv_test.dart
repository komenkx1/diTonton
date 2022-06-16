import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTVSeriesRepository);
  });

  final tTVSeries = <TvSeries>[];

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}
