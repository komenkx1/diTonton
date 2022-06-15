part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesEmpty extends NowPlayingTvSeriesState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  String message;
  NowPlayingTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvSeriesHasData extends NowPlayingTvSeriesState {
  final List<TvSeries> result;

  NowPlayingTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
