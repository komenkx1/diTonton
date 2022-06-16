part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesEvent extends Equatable {
  const RecommendationTvSeriesEvent();
}

class RecommendationTvSeriesLoad extends RecommendationTvSeriesEvent {
  final int id;

  RecommendationTvSeriesLoad(this.id);

  @override
  List<Object> get props => [];
}
