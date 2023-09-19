import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/cart/bloc/cart_bloc.dart';
import '../../models/product_model.dart';
import '../../presentation/product_details.dart';
import '../../utils/constances.dart';
import '../custom_text.dart';

// ignore: must_be_immutable
class SammaryStep extends StatelessWidget {
  SammaryStep({super.key,required this.city,required this.userstate,required this.phonenumber,required this.street,});
TextEditingController userstate=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController street=TextEditingController();
 TextEditingController phonenumber=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return SizedBox(
            height: 430.h,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220.h,
                  width: double.infinity,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:  state.cartitems  .map((product) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductDetails(productModel: product);
                              },
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 9.w),
                            height: double.infinity,
                            width: 180.w,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.h),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(4.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: SizedBox(
                                        height: 90.h,
                                        width: 90.w,
                                        child:
                                   CachedNetworkImage( height: 90.h,width: 90.w,
        imageUrl:product.productimage,
        placeholder: (context, url) => Center(child: CircularProgressIndicator(color: greencolor,)),
        errorWidget: (context, url, error) =>const  Icon(Icons.error),
     ),             
                                            
                                            ),
                                  ),
                                  CustomText(
                                    text: product.productname,
                                    fontWeight: FontWeight.bold,
                                    size: 20.sp,
                                    textalign: TextAlign.right,
                                  ),
                                  CustomText(
                                    text: 'Quantite:${product.productQantite}',
                                    fontWeight: FontWeight.bold,
                                    size: 16.sp,
                                    textalign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 7.w, right: 7.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              '${product.productQantite * double.parse(product.pruductprice)}',
                                          fontWeight: FontWeight.bold,
                                          size: 20.sp,
                                          color: blackcolor,
                                        ),
                                        TextButton(
                                            onPressed: () {},
                                            child: Container(
                                              height: 30.h,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                  color: greencolor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.h))),
                                              child: Center(
                                                child: Icon(
                                                  Icons
                                                      .disabled_by_default_sharp,
                                                  color: Colors.white,
                                                  size: 22.h,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  text: 'State :${userstate.text}',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text: 'City :${city.text}',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text: 'Street:${street.text}',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text:
                      'Phone Number:${phonenumber.text}',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text:
                      'Delivery Price:${50}',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ),

                CustomText(
                  text:
                      'Totale Price:${100+gettotale(state.cartitems)}\$',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ),
              ],
            ));
      },
    );
  }
    double gettotale(List<ProductModel> cart) {
    return cart
        .fold(
            00,
            (sum, product) => sum + (product.productQantite * double.parse(product.pruductprice)));
        
  }
}