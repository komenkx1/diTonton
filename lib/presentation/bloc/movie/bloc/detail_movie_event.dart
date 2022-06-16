part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class DetailMovieLoad extends DetailMovieEvent {
  final int id;

  DetailMovieLoad(this.id);

  @override
  List<Object> get props => [];
}
