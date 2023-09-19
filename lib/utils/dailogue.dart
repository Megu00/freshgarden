
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/authentification/auth_bloc.dart';

class Dialogs{
 Future <dynamic>showdialogue(BuildContext context)async{
 
    CoolAlert.show(
     animType:CoolAlertAnimType.scale ,
     cancelBtnTextStyle:TextStyle(
      color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20.sp
     ),
   context: context,
   confirmBtnText:'Sign Out',
   
   cancelBtnText:'Back',

  confirmBtnColor: Colors.black87,
  confirmBtnTextStyle: TextStyle(
    fontWeight: FontWeight.bold,fontFamily: 'Righteous',fontSize: 20.sp,
    color: Colors.white
  ),

  
   onConfirmBtnTap: (){
    context.read<AuthBloc>().add(SignOutEvent());

   },
   closeOnConfirmBtnTap: true,
   
   type: CoolAlertType.confirm,
    title: "Do you want to Sign Out"
);
  }


}