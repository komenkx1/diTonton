part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {
  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  String message;
  TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvSeriesHasData extends TopRatedTvSeriesState {
  final List<TvSeries> result;

  TopRatedTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
