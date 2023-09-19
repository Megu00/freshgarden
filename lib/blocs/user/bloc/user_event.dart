// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetuserInfoEvent extends UserEvent {}

class UpdateImageEvent extends UserEvent {
  final ImageSource imageSource;
  const UpdateImageEvent({
    required this.imageSource,
  });
}

class UpdateUserInfo extends UserEvent {
  final Map<String, dynamic> updateUserdata;
  const UpdateUserInfo({
    required this.updateUserdata,
  });
}

class UpdateUserGendre extends UserEvent {
  final String selectedGendre;
  const UpdateUserGendre({
    required this.selectedGendre,
  });

  
}
   class  CheckUserAuthEvent extends UserEvent{}