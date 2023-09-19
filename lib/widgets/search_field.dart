import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constances.dart';

class SearchField extends StatelessWidget {
 const  SearchField({super.key,required this.search,required this.onChanged,this.onPressed,this.prefixIcon});
 final TextEditingController search;
 final Function(String)? onChanged;
 final Function()? onPressed;
 final Widget ? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return   Padding(padding: EdgeInsets.only(left: 10.w,right: 10.h,bottom: 10.h),
      child: TextFormField(
    
        controller: search,onChanged: onChanged,
                  decoration: InputDecoration(
    
                    
                      focusColor: greencolor,
                      hintText: 'Seach Store',
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h))),
                      prefixIcon:  prefixIcon,
                        
                      
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10.h))),
                      filled: true,
                      fillColor: seachchcolor)),
    );
  }
}