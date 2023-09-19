import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_text.dart';
import 'constances.dart';

class ProductUtulities {
  String convertdouble(String price, int quantite) {
    return (double.parse(price) * quantite).toStringAsFixed(2);
  }

  Widget buildsalleWidge(
    int sallepourcentage,
    String producprice,
  ) {
    if (sallepourcentage == 0) {
      return CustomText(
        text: '$producprice\$',
        fontWeight: FontWeight.bold,
        size: 20.sp,
        color: blackcolor,
      );
    } else {
      return Column(
        children: [
          Text(
            '${_calculatesalleprice(producprice, sallepourcentage)}\$',
            style: TextStyle(
                decorationColor: Colors.black,
                decorationThickness: 2,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                decorationStyle: TextDecorationStyle.dashed,
                fontFamily: 'Righteous',
                fontSize: 16.sp,
                color: Colors.red),
          ),
          SizedBox(height: 3.h),
          CustomText(
            text: '$producprice\$',
            fontWeight: FontWeight.bold,
            size: 20.sp,
            color: blackcolor,
          )
        ],
      );
    }
  }

  Widget buildsallewidget2(int sallepourcentage, String productprice) {
    if (sallepourcentage == 0) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
          ),
          CustomText(
            text: '$productprice\$',
            fontWeight: FontWeight.bold,
            size: 22.sp,
          )
        ],
      );
    } else {
      return Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Text(
            '${_calculatesalleprice(productprice, sallepourcentage)}\$',
            style: TextStyle(
                decorationColor: Colors.black,
                decorationThickness: 2,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                decorationStyle: TextDecorationStyle.dashed,
                fontFamily: 'Righteous',
                fontSize: 22.sp,
                color: Colors.red),
          ),
          SizedBox(width: 20.h),
          CustomText(
            text: '$productprice\$',
            fontWeight: FontWeight.bold,
            size: 22.sp,
            color: blackcolor,
          )
        ],
      );
    }
  }

  String _calculatesalleprice(String productprice, int sallepourcentage) {
    double salleprice = sallepourcentage * double.parse(productprice) / 100;
    return '${double.parse(productprice) - salleprice}';
  }
}
