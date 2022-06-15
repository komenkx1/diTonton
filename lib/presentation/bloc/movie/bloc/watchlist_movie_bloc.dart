import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchlistStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchlistStatus,
      this._removeWatchlist, this._saveWatchlist)
      : super(WatchlistMovieEmpty()) {
    on<OnGotWatchlistMovie>(
      (event, emit) async {
        emit(WatchlistMovieLoading());

        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WatchlistMovieError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(WatchlistMovieHasData(data));
            } else {
              emit(WatchlistMovieEmpty());
            }
          },
        );
      },
    );
    on<GotWatchlistMovie>(
      (event, emit) async {
        final id = event.id;

        final result = await _getWatchlistStatus.execute(id);

        emit(InsertDataMovieToWatchlist(result));
      },
    );
    on<InsertWatchlistMovie>(
      (event, emit) async {
        emit(WatchlistMovieLoading());

        final movie = event.movie;

        final result = await _saveWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(WatchlistMovieError(failure.message));
          },
          (message) {
            emit(MessageMovieWatchlist(message));
            emit(InsertDataMovieToWatchlist(true));
          },
        );
      },
    );
    on<DeleteWatchlistMovie>(
      (event, emit) async {
        final movie = event.movie;

        final result = await _removeWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(WatchlistMovieError(failure.message));
          },
          (message) {
            emit(MessageMovieWatchlist(message));
            emit(InsertDataMovieToWatchlist(false));
          },
        );
      },
    );
  }
}
