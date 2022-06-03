import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataSource dataSourceImpl;
  late MockHttpClient mockHttpClient;
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TV Series', () {
    final testTVShowList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_on_air.json')))
        .results;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_on_air.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSourceImpl.getNowPlayingTvSeries();
      print(result);
      print(testTVShowList);
      // assert
      expect(result, equals(testTVShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getNowPlayingTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Detail', () {
    final id = 2;
    final testTVDetail = TvSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));
    test('should be return tv show detail when the response code is 200',
        () async {
      //arrage
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await dataSourceImpl.getTvSeriesDetail(id);
      //assert
      expect(result, equals(testTVDetail));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrage
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSourceImpl.getTvSeriesDetail(id);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Recommendations', () {
    final testRecommendationTVShowList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .results;
    final id = 1;
    test(
        'should be return  tv show recommendation when the response code is 200',
        () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_recommendations.json'), 200));
      // act
      final result = await dataSourceImpl.getTvSeriesRecommendations(id);
      //assert
      expect(result, equals(testRecommendationTVShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getTvSeriesRecommendations(id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV shows', () {
    final testTVShowList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_popular.json')))
        .results;

    test('should return list of tv shows when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_popular.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSourceImpl.getPopularTvSeries();
      // assert
      expect(result, testTVShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get Top Rated TV shows', () {
    final testTVShowList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_top_rated.json')))
        .results;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_top_rated.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSourceImpl.getTopRatedTvSeries();
      // assert
      expect(result, testTVShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    final tSearchResult = TvSeriesResponse.fromJson(json
            .decode(readJson('dummy_data/search_wanda_vision_tv_series.json')))
        .results;
    final query = 'Avengers';
    test('should be return list of tv shows when response code is 200',
        () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_wanda_vision_tv_series.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await dataSourceImpl.searchTvSeries(query);

      //assert
      expect(result, tSearchResult);
    });

    test('should be throw ServerException when response code is other 200',
        () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSourceImpl.searchTvSeries(query);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
