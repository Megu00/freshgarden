part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String useremail;
  final String userpass;
  final String username;
  const RegisterEvent({
    required this.useremail,
    required this.userpass,
     required this.username
  });
}
class Chekevent extends AuthEvent{}
class SignInEvent extends AuthEvent {
 final String useremail;
 final String userpass;
 const SignInEvent({
    required this.useremail,
    required this.userpass,
  });
}

class SignOutEvent extends AuthEvent {

}

class ErrorEvent extends AuthEvent{}

class LoadingAuthEvent extends AuthEvent{}
