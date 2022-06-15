import 'package:ditonton/data/models/tv_series/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonTvSeriesModel = SeasonModel(
    id: 1,
    name: 'season',
    posterPath: 'poster',
    episodeCount: 2,
    seasonNumber: 2,
    airDate: '',
    overview: '',
  );

  group('Test Model for Tv Series Season', () {
    test('should be a subclass of Tv Series Detail entity', () async {
      final testSeason = tSeasonTvSeriesModel.toEntity();

      final result = tSeasonTvSeriesModel.toEntity();
      expect(result, testSeason);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final testSeasonMap = tSeasonTvSeriesModel.toJson();
      // act
      final result = tSeasonTvSeriesModel.toJson();
      // assert
      expect(result, testSeasonMap);
    });
  });
}
