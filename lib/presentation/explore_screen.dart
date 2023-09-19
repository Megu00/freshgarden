import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/product_bloc/category_bloc/bloc/category_bloc.dart';

import 'package:fresh_garden/presentation/prouduct_bycategory.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import '../utils/constances.dart';


class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final List<Color> colors = [
    orangcategory,
    pinkcategory,
    blucategory,
    greencategory,
    greencolor,
    yellowcategory
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is LoadingCtaegory) {
          return Center(
            child: CircularProgressIndicator(color: greencolor),
          );
        }
        if (state is CategoryLoaded) {
          return SafeArea(minimum: EdgeInsets.all(5.h),
              child: Column(children: [
                SizedBox(
                  height: 15.h,
                ),
                CustomText(
                  text: 'Find Products',
                  fontWeight: FontWeight.bold,
                  size: 23.sp,
                ),
                SizedBox(
                  height: 15.h,
                ),
                
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: state.categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7.h,
                        mainAxisSpacing: 7.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProuductByCategory(
                                categoryName:
                                    state.categories[index].categoryname,
                              );
                            },
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 9.w),
                          decoration: BoxDecoration(
                              color: colors[index],
                              border: Border.all(
                                  color: const Color(0xFFE5E5E5)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.h),
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(4.h),
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100.h,
                                    width: 100.w,
                                    child: CachedNetworkImage(
                                      height: 90.h,
                                      width: 90.w,
                                      imageUrl: state
                                          .categories[index].categoryimage,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                        color: greencolor,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  CustomText(
                                    text: state
                                        .categories[index].categoryname,
                                    fontWeight: FontWeight.bold,
                                    size: 15.sp,
                                    textalign: TextAlign.center,
                                  ),
                                  CustomText(
                                    text: '1kg ,Price',
                                    fontWeight: FontWeight.w300,
                                    size: 15.sp,
                                    textalign: TextAlign.right,
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ]));
        }
        return  Center(
                child: CustomText(text: 'Loading',fontWeight: FontWeight.bold,size: 20.sp,)
              );
      },
    ));
  }
}
