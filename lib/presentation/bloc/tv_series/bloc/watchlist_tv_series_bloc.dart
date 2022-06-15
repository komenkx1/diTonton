import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getDataWatchlistTvSeries;
  final GetWatchListStatusTvSeries _getDataTvSeriesWatchListStatus;
  final SaveWatchlistTvSeries _saveTvSeriesFromWatchlist;
  final RemoveWatchlistTvSeries _deleteTvSeriesFromWatchlist;

  WatchlistTvSeriesBloc(
      this._getDataWatchlistTvSeries,
      this._getDataTvSeriesWatchListStatus,
      this._saveTvSeriesFromWatchlist,
      this._deleteTvSeriesFromWatchlist)
      : super(WatchlistTvSeriesEmpty()) {
    on<OnGotWatchlistTvSeries>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());

        final result = await _getDataWatchlistTvSeries.execute();

        result.fold(
          (failure) {
            emit(WatchlistTvSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(WatchlistTvSeriesHasData(data));
            } else {
              emit(WatchlistTvSeriesEmpty());
            }
          },
        );
      },
    );
    on<GotWatchlistTvSeries>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());
        final id = event.id;

        final result = await _getDataTvSeriesWatchListStatus.execute(id);
        emit(InsertDataTvSeriesToWatchlist(result));
      },
    );
    on<InsertWatchlistTvSeries>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());

        final tvSeries = event.tvSeriesDetail;

        final result = await _saveTvSeriesFromWatchlist.execute(tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTvSeriesError(failure.message));
          },
          (message) {
            emit(MessageTvSeriesWatchlist(message));
            emit(InsertDataTvSeriesToWatchlist(true));
          },
        );
      },
    );
    on<DeleteWatchlistTvSeries>(
      (event, emit) async {
        emit(WatchlistTvSeriesLoading());

        final tvSeries = event.tvSeriesDetail;

        final result = await _deleteTvSeriesFromWatchlist.execute(tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTvSeriesError(failure.message));
          },
          (message) {
            emit(MessageTvSeriesWatchlist(message));
            emit(InsertDataTvSeriesToWatchlist(false));
          },
        );
      },
    );
  }
}
