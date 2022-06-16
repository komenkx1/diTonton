part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();
}

class OnNowPlayingMoviesLoad extends NowPlayingMoviesEvent {
  @override
  List<Object?> get props => [];
}
