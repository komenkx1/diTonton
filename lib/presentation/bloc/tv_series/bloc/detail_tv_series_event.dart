part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();
}

class DetailTvSeriesLoad extends DetailTvSeriesEvent {
  final int id;

  DetailTvSeriesLoad(this.id);

  @override
  List<Object> get props => [];
}
