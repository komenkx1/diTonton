import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnPageChanged extends HomeEvent {
  final int index;

  OnPageChanged(this.index);

  @override
  List<Object> get props => [index];
}
