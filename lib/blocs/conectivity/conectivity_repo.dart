import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConectivityRepo{
 final Connectivity _connectivity = Connectivity();

 Stream<ConnectivityResult>checkconectivity(){

 return  _connectivity.onConnectivityChanged;

  
  


  }



}