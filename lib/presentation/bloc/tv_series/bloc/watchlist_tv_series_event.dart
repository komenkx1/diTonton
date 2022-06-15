part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();
}

class OnGotWatchlistTvSeries extends WatchlistTvSeriesEvent {
  @override
  List<Object> get props => [];
}

class GotWatchlistTvSeries extends WatchlistTvSeriesEvent {
  final int id;

  GotWatchlistTvSeries(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistTvSeries extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  InsertWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class DeleteWatchlistTvSeries extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  DeleteWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
