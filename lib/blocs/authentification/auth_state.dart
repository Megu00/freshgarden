part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoggedInState extends AuthState{}

class ItsnotLoggedInState extends AuthState{}

class LoadingState extends AuthState{}
class Errorstate extends AuthState {
 final String errortext;
 const Errorstate({
    required this.errortext,
  });
}
