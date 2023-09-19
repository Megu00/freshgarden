

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/barnner/bloc/barnner_bloc.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import '../utils/constances.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarnnerBloc,BarnnerState>(builder: (context, state) {

      if(state is BarnnerLoading){
        return SizedBox(height: 130,width: double.infinity
        ,child: Center(child: CircularProgressIndicator(color: greencolor)),);
      }
      if(state is BarnnerError){
        return Center(child: CustomText(text: state.errortext,fontWeight: FontWeight.bold,size: 10.sp),);
      }
         if(state is BarnnerLoaded){

          return  SizedBox(
                      height: 130.h,
                      child: CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true, enlargeCenterPage: true),
                        items: state.barrner.map((e) {
                          return Container(
                            height: 60.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(e.data['bimage']),fit: BoxFit.cover
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.h))),
                          );
                        }).toList(),
                      ),
                    );
         }
         return const SizedBox.shrink();
    },);
  }
}