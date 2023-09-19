import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/cart/bloc/cart_bloc.dart';
import 'package:fresh_garden/presentation/product_details.dart';

import '../models/product_model.dart';
import '../utils/constances.dart';

import '../utils/product_claculate.dart';
import 'custom_text.dart';

class ProductsHome extends StatelessWidget {
   ProductsHome({super.key, required this.products});
  final List<ProductModel> products;
  final ProductUtulities _productUtulities=ProductUtulities();
  @override
  Widget build(BuildContext context) {
    CartBloc cart = BlocProvider.of<CartBloc>(context);
    return SizedBox(
      height: 230.h,
      width: double.infinity,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: products.map((product) {
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
                width: 155.w,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5E5)),
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
                            child: Image.network(product.productimage)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                     Column(children: [
                       CustomText(
                        text: product.productname.toUpperCase(),
                        fontWeight: FontWeight.bold,
                        size: 15.sp,
                        textalign: TextAlign.right,
                      ),
                     ],),
                      CustomText(
                        text: '1kg ,Price',
                        fontWeight: FontWeight.w300,
                        size: 15.sp,
                        textalign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 7.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _productUtulities.buildsalleWidge(product.sallepourcentage,product.pruductprice),
                            TextButton(
                                onPressed: () {
                                  if (cart.state.cartitems.contains(product)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: CustomText(
                                      text: 'you Have Alredy Add This Product',
                                      fontWeight: FontWeight.bold,
                                    )));
                                  } else {
                                    context
                                        .read<CartBloc>()
                                        .add(AddProduct(productModel: product));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: CustomText(
                                      text: 'Product Added To Cart',
                                      fontWeight: FontWeight.bold,
                                    )));
                                  }
                                },
                                child: Container(
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                      color: greencolor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.h))),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 27.h,
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
    );
  }

  
}
