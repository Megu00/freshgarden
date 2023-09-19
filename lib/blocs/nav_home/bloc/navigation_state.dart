part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
  
  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}
class Changedindexstate extends NavigationState {
final int currentindex;
  const   Changedindexstate({required this.currentindex});
  @override
  List<Object> get props => [currentindex];

}
