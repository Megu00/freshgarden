

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(const Changedindexstate(currentindex: 0)) {
    on<Changeindexevent>((event, emit) {
      emit(Changedindexstate(currentindex: event.index));
    });
  }
}
