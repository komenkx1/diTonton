part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesEmpty extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTvSeriesLoading extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class PopularTvSeriesError extends PopularTvSeriesState {
  String message;
  PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvSeriesHasData extends PopularTvSeriesState {
  final List<TvSeries> result;

  PopularTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
