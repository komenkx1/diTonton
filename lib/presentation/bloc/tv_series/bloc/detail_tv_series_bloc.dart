import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  DetailTvSeriesBloc(this._getTvSeriesDetail) : super(DetailTvSeriesEmpty()) {
    on<DetailTvSeriesAppellation>(
      (event, emit) async {
        final id = event.id;

        emit(DetailTvSeriesLoading());
        final result = await _getTvSeriesDetail.execute(id);

        result.fold(
          (failure) {
            emit(DetailTvSeriesError(failure.message));
          },
          (data) {
            emit(DetailTvSeriesHasData(data));
          },
        );
      },
    );
  }
}
