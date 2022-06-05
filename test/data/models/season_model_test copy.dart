

import 'package:ditonton/data/models/tv_series/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonTVSeriesModel = SeasonModel(
    id: 1,
    name: 'season',
    posterPath: 'poster',
    episodeCount: 2,
    seasonNumber: 2,
    airDate: '',
    overview: '',
  );

  group('Test Model for TV Series Season', () {
    test('should be a subclass of TV Series Detail entity', () async {
      final testSeason = tSeasonTVSeriesModel.toEntity();

      final result = tSeasonTVSeriesModel.toEntity();
      expect(result, testSeason);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final testSeasonMap = tSeasonTVSeriesModel.toJson();
      // act
      final result = tSeasonTVSeriesModel.toJson();
      // assert
      expect(result, testSeasonMap);
    });
  });
}
