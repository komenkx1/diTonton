import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<TopRatedMoviesEvent>(
      (event, emit) async {
        emit(TopRatedMoviesLoading());

        final result = await _getTopRatedMovies.execute();

        result.fold(
          (failure) {
            emit(TopRatedMoviesError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(TopRatedMoviesHasData(data));
            } else {
              emit(TopRatedMoviesEmpty());
            }
          },
        );
      },
    );
  }
}
