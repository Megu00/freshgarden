import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/product_bloc/product_bloc/product_bloc.dart';
import 'package:fresh_garden/models/product_model.dart';

import '../widgets/custom_text.dart';

class ShoRatingDialog{


  Future ratingdialoge(BuildContext context,double initialRating,ProductModel productModel)async{
         showDialog(context: context, builder: (context) {
       return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.h))),
        contentPadding: EdgeInsets.all(5.h),
        content: SizedBox(height: 200.h,width: 300.w,
        child: Column(children: [
            SizedBox(height: 7.h,),
           CustomText(text: 'Rate This Product',color: Colors.red,fontWeight: FontWeight.w500,size: 22.sp,),

           SizedBox(height: 16.h,),
                RatingBar.builder(
   initialRating: initialRating,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount:5 ,
   itemPadding:  EdgeInsets.symmetric(horizontal: 3.w),
   itemBuilder: (context, _) => const Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
   context.read<ProductBloc>().add(RatingProductEvent(ratingproduct: rating, productModel: productModel, productId: productModel.productid));

   }),


   SizedBox(height: 25.h,),


      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Container(height: 40.h,width: 100.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(22.h)),border: Border.all(color: Colors.amber))  ,
      child: Center(child: CustomText(text: 'Back',color: Colors.black,fontWeight: FontWeight.bold,size: 20.sp,),),
      ))
        ]),
       
       
       
       
       ),);
     },);

  }





}