part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();

  @override
  List<Object> get props => [];
}

class DetailTvSeriesEmpty extends DetailTvSeriesState {
  @override
  List<Object> get props => [];
}

class DetailTvSeriesLoading extends DetailTvSeriesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DetailTvSeriesError extends DetailTvSeriesState {
  String message;
  DetailTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvSeriesHasData extends DetailTvSeriesState {
  final TvSeriesDetail result;

  DetailTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
