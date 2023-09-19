import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fresh_garden/blocs/blocs.dart';
import 'package:fresh_garden/utils/product_claculate.dart';

import '../models/product_model.dart';
import '../presentation/product_details.dart';
import '../utils/constances.dart';
import 'custom_text.dart';

class RandomSearch extends StatelessWidget {
  RandomSearch({super.key});

  final ProductUtulities _productUtulities = ProductUtulities();
  @override
  Widget build(BuildContext context) {
    CartBloc cart = BlocProvider.of<CartBloc>(context);
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              final List<ProductModel> products = _buildRandomProduct(state.products);
              return GridView.builder(
                
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 0.7.h,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 5.h,
              ),
            
              itemCount: products.length,
              
               itemBuilder:(context, index) {
              ProductModel product=products[index];
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
                            Column(
                              children: [
                                CustomText(
                                  text: product.productname.toUpperCase(),
                                  fontWeight: FontWeight.bold,
                                  size: 15.sp,
                                  textalign: TextAlign.right,
                                ),
                              ],
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _productUtulities.buildsalleWidge(
                                      product.sallepourcentage,
                                      product.pruductprice),
                                  TextButton(
                                      onPressed: () {
                                        if (cart.state.cartitems
                                            .contains(product)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: CustomText(
                                            text:
                                                'you Have Alredy Add This Product',
                                            fontWeight: FontWeight.bold,
                                          )));
                                        } else {
                                          context.read<CartBloc>().add(
                                              AddProduct(
                                                  productModel: product));
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
               },);
            }
            return const SizedBox.shrink();
          },
        ));
  }
   List<ProductModel> _buildRandomProduct(List<ProductModel>products){
   products.sublist(0,9).shuffle();
   return products;
  }
}
