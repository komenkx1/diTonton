part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();
}

class RecommendationMoviesLoad extends RecommendationMoviesEvent {
  final int id;

  RecommendationMoviesLoad(this.id);

  @override
  List<Object> get props => [];
}
