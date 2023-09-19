import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constances.dart';

class CutomBotton extends StatelessWidget {
 const CutomBotton({super.key,required this.function,required this.mw,required this.bottontext});
 final double mw;
 final VoidCallback function;
 final String bottontext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 46.h,width:mw,
                      child: TextButton(onPressed: function,
                      style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(greencolor),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h))),
                       ), child:  Center(child: Text(bottontext,style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22.h),),
                       
                      ),
                      
                      ),
                    );
  }
}