part of 'conectivity_bloc.dart';

 class ConectivityEvent extends Equatable {
  const ConectivityEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectivity extends ConectivityEvent{}

class ConectEvent extends ConectivityEvent{}
class DisconectEvent extends ConectivityEvent{}