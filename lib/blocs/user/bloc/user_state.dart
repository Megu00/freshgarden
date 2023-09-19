// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

 class UserState  extends Equatable  {

  
  @override
  List<Object> get props => [];
}
class UserLoaded extends UserState {
  final  UserModel userModel;
  UserLoaded({required this.userModel});
    @override
  List<Object> get props => [userModel];
}


class UserLoadingState extends UserState {
final bool islaoding;
 UserLoadingState({
     this.islaoding=false
  });
}
// ignore: must_be_immutable
class UserGendreUpdate extends UserState {
 String  usergendre='man';
  UserGendreUpdate({
  required this.usergendre
  });
   @override
  List<Object> get props => [usergendre];



}




