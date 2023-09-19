import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_text.dart';

class DeliveryStep extends StatelessWidget {
  const DeliveryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxListTile(
              value: true,
              onChanged: (value) {},
              title: SizedBox(
                  height: 150,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Standar Delivery',
                        fontWeight: FontWeight.bold,
                        size: 23.sp,
                      ),
                      CustomText(
                        text: 'order will be delivred under 3 and 5 days ',
                        fontWeight: FontWeight.w300,
                        size: 20.sp,
                      ),
                    ],
                  ))),
          CheckboxListTile(
              value: true,
              activeColor: Colors.grey,
              onChanged: (value) {},
              title: SizedBox(
                  height: 150,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Next Day',
                        fontWeight: FontWeight.bold,
                        size: 23.sp,
                      ),
                      CustomText(
                        text:
                            'pace Your Order And You Will Receive Your Product Next Day',
                        fontWeight: FontWeight.w300,
                        size: 20.sp,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
