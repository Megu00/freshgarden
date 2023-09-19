import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';



import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';
import '../user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  
   StreamSubscription ?streamSubscription;
  UserBloc({required UserRepo userRepo,})
      : _userRepo=userRepo,
        super(UserLoaded(
            userModel: UserModel(
                username: '',
                useremail: '',
                userpass: '',
                userimage: '',
                userbirthday: '',
                userphone: '',
                userId: '',
                usergendre: 'men'))) {
    on<GetuserInfoEvent>((event, emit) async {
      try {
        UserModel userModel;
        userModel = await _userRepo.getuserinfo();
      
        emit(UserLoaded(userModel: userModel));
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
    on<UpdateImageEvent>((event, emit) async {
      try {
        if (state is UserLoaded) {
          await _userRepo.updateuserimage(event.imageSource);
          emit(UserLoadingState());
          final UserModel userModel = await _userRepo.getuserinfo();
          emit(UserLoaded(userModel: userModel));
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });

    on<UpdateUserInfo>((event, emit) async {
             
      try {
        if(state is UserLoaded){
     emit(UserLoadingState(islaoding: true));       
        await _userRepo.updattesernfo(event.updateUserdata);
       
       emit(UserLoaded(userModel: await _userRepo.getuserinfo()));
        
        }
      
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });

    on<UpdateUserGendre>((event, emit) {
      emit(UserGendreUpdate(usergendre: event.selectedGendre));
    });
    
  }

}
