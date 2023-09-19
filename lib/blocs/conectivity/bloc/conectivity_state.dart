// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'conectivity_bloc.dart';

 class ConectivityState extends Equatable {
  const ConectivityState();
  
  @override
  List<Object> get props => [];
}

 class ConectivityInitial extends ConectivityState {}

class ConectivitySuccess extends ConectivityState {
 final String info;
 const ConectivitySuccess({
    this.info='Success'
  });
 }

class ConnectivityFail extends ConectivityState {
  final String info;
 const ConnectivityFail({
    required this.info,
  });
}
