import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custum_textformdield.dart';
// ignore: must_be_immutable

// ignore: must_be_immutable
class AdressStep extends StatelessWidget {
   AdressStep({super.key,required this.state,required this.city,required this.street,
   required this.phonenumber,required this.globalKey});
 final TextEditingController state;
 final TextEditingController city;
 final TextEditingController street;
 final TextEditingController phonenumber;
GlobalKey<FormState> globalKey = GlobalKey<FormState>();

 

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 430.h,width: double.infinity,
      child: Form(
        key: globalKey,
        child: Column(
          children: [
            CustumTextformfield(redaonly: false,
              labelText: 'State',
              controller: state,
              maxLength: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustumTextformfield(redaonly: false,
              labelText: 'City',
              controller: city,
              maxLength: 10,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustumTextformfield( redaonly: false,
              labelText: 'Street',
              maxLength: 10,
              controller: street
            ),
            SizedBox(
              height: 10.h,
            ),
            CustumTextformfield( redaonly: false,maxLength: 10,
                labelText: 'Phone Numbe',
                controller: phonenumber,
                textInputType: TextInputType.phone),
          ],
        ),
      ),
    );
  }
}