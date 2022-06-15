part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTvSeries extends SearchTvSeriesEvent {
  final String query;

  OnQueryChangedTvSeries(this.query);

  @override
  List<Object> get props => [query];
}
