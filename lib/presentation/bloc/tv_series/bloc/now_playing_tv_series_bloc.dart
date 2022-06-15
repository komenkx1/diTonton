import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _getOnTheAirTvSeries;

  NowPlayingTvSeriesBloc(this._getOnTheAirTvSeries)
      : super(NowPlayingTvSeriesEmpty()) {
    on<NowPlayingTvSeriesAppellation>(
      (event, emit) async {
        emit(NowPlayingTvSeriesLoading());

        final result = await _getOnTheAirTvSeries.execute();

        result.fold(
          (failure) {
            emit(NowPlayingTvSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(NowPlayingTvSeriesHasData(data));
            } else {
              emit(NowPlayingTvSeriesEmpty());
            }
          },
        );
      },
    );
  }
}
