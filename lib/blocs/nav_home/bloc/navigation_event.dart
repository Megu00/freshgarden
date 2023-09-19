part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Changeindexevent extends NavigationEvent {
   final int index;
  const Changeindexevent({
    required this.index,
  });




}

class BackToHomeScreen extends NavigationEvent{}
