part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesEvent extends Equatable {
  const RecommendationTvSeriesEvent();
}

class RecommendationTvSeriesAppellation extends RecommendationTvSeriesEvent {
  final int id;

  RecommendationTvSeriesAppellation(this.id);

  @override
  List<Object> get props => [];
}
