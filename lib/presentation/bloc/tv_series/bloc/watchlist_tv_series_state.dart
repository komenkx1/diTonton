part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  String message;
  WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  WatchlistTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertDataTvSeriesToWatchlist extends WatchlistTvSeriesState {
  final bool watchlistStatus;

  InsertDataTvSeriesToWatchlist(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

class MessageTvSeriesWatchlist extends WatchlistTvSeriesState {
  final String message;

  MessageTvSeriesWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
