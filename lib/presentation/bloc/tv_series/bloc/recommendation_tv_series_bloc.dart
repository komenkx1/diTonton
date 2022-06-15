import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_series_event.dart';
part 'recommendation_tv_series_state.dart';

class RecommendationTvSeriesBloc
    extends Bloc<RecommendationTvSeriesEvent, RecommendationTvSeriesState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  RecommendationTvSeriesBloc(this._getTvSeriesRecommendations)
      : super(RecommendationTvSeriesEmpty()) {
    on<RecommendationTvSeriesAppellation>(
      (event, emit) async {
        final id = event.id;
        emit(RecommendationTvSeriesLoading());

        final result = await _getTvSeriesRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(RecommendationTvSeriesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(RecommendationTvSeriesHasData(data));
            } else {
              emit(RecommendationTvSeriesEmpty());
            }
          },
        );
      },
    );
  }
}
