import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/home_event.dart';
import 'package:ditonton/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // EventTransformer<T> debounce<T>(Duration duration) {
  //   return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  // }

  HomeBloc() : super(HomeEmpty()) {
    on<OnPageChanged>((event, emit) {
      final index = event.index;
      emit(HomeHasData(index));
    });
  }
}
