part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();
}

class DetailTvSeriesAppellation extends DetailTvSeriesEvent {
  final int id;

  DetailTvSeriesAppellation(this.id);

  @override
  List<Object> get props => [];
}
