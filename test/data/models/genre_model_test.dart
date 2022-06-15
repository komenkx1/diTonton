import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: 'season',
  );

  group('Test Model for Genre Tv or Movie', () {
    test('should be a subclass of Genre entity', () async {
      final testGenre = tGenreModel.toEntity();

      final result = tGenreModel.toEntity();
      expect(result, testGenre);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final testGenreMap = tGenreModel.toJson();
      // act
      final result = tGenreModel.toJson();
      // assert
      expect(result, testGenreMap);
    });
  });
}
