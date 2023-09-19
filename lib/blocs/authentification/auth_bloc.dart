
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'package:fresh_garden/blocs/authentification/auth_repositories.dart';

import '../user/bloc/user_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
 
 final  AuthRepositories _authRepositories;
 final SharedPreferences _sharedPreferences;
 final UserBloc _userBloc;
  AuthBloc(
 {  required AuthRepositories authRepositories,required SharedPreferences sharedPreferences,required UserBloc userBloc
 }
  ) :_authRepositories=authRepositories,
  _sharedPreferences=sharedPreferences,
  _userBloc=userBloc,
  
  
  
  
   super(AuthInitial()) {
    on<Chekevent>((event, emit) async {
      sharedPreferences=await SharedPreferences.getInstance();
      bool islogin = _sharedPreferences.getBool('status')??false;
      try {
        emit(LoadingState());
        if (islogin == true) {
          emit(LoggedInState());
          
         
        } else {
          emit(ItsnotLoggedInState());
        }
      } catch (e) {
        emit(Errorstate(errortext: '$e'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      
      try {
        emit(LoadingState());
        bool status= await _authRepositories.registeruser(
            event.useremail, event.userpass,event.username);
        if (status != false) {
          emit(LoggedInState());
         _userBloc.add(GetuserInfoEvent());
        } else {
    
          emit(ItsnotLoggedInState());
        }
      } catch (e) {
        
        emit(Errorstate(errortext: e.toString()));
      }
    });
    on<SignInEvent>((event, emit) async {
      
      try {
        emit(LoadingState());
        bool status= await _authRepositories.signInuser(event.useremail, event.userpass);
            _userBloc.add(GetuserInfoEvent());   
        if (status != false) {
       
          emit(LoggedInState());
        }
      } catch (e) {
        emit(Errorstate(errortext: e.toString()));
      }
    });
    on<SignOutEvent>((event, emit) async {
      try {
        _authRepositories.logout();

        emit(ItsnotLoggedInState());
      } catch (e) {
        emit(Errorstate(errortext: e.toString()));
        emit(ItsnotLoggedInState());
      }
    });
  }
  @override
  void onChange(Change<AuthState> change) {
    Change(currentState: LoggedInState(), nextState: LoadingState);
    super.onChange(change);
  }
}
