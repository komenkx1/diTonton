// To parse this JSON data, do
//
//     final tvSeriesResponse = tvSeriesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ditonton/data/models/tv_series/tv_series_model.dart';

TvSeriesResponse tvSeriesResponseFromJson(String str) =>
    TvSeriesResponse.fromJson(json.decode(str));

String tvSeriesResponseToJson(TvSeriesResponse data) =>
    json.encode(data.toJson());

class TvSeriesResponse {
  TvSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<TvSeriesModel> results;
  final int totalPages;
  final int totalResults;

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        page: json["page"],
        results: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.overview != "")),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
