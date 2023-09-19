import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
part 'conectivity_event.dart';
part 'conectivity_state.dart';

class ConectivityBloc extends Bloc<ConectivityEvent, ConectivityState> {
  final Connectivity _connectivity = Connectivity();
  // final ConectivityRepo conectivityRepo=ConectivityRepo();
  late StreamSubscription<ConnectivityResult> streamSubscription;
  ConectivityBloc() : super(ConectivityInitial()) {
    on<ConectEvent>((event, emit) => emit(const ConectivitySuccess(info: 'connect')));
    on<DisconectEvent>((event, emit) => emit(const ConnectivityFail(info: 'Disconnect')));
    on<CheckConnectivity>((event, emit) async {
      try {
        streamSubscription = _connectivity.onConnectivityChanged
            .listen((ConnectivityResult connectivityResult) {
          if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi) {
          add(ConectEvent());
          }else{
            add(DisconectEvent());
          }
        });
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
      
      
    });
  
  }
   @override
 Future<void>close(){
  streamSubscription.cancel();
 return super.close();
 } 
  
}
