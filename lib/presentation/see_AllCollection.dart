

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/presentation/product_details.dart';

import '../blocs/cart/bloc/cart_bloc.dart';
import '../models/product_model.dart';
import '../utils/constances.dart';
import '../utils/product_claculate.dart';
import '../widgets/custom_text.dart';
import '../widgets/show_snackbar.dart';

class SeeAll extends StatelessWidget {
   SeeAll({super.key,required this.products,required this.productCollection});
final List<ProductModel>products;
final String productCollection;
final ProductUtulities _productUtulities=ProductUtulities();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    
     SafeArea(minimum: EdgeInsets.all(5.h),
              child: Column(children: [
                SizedBox(
                  height: 15.h,
                ),
                Row(children: [
                    IconButton(
                        onPressed: () {
                        
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: 50.w,
                    ),
                     CustomText(
                  text: productCollection,
                  fontWeight: FontWeight.bold,
                  size: 23.sp,
                ),
                    
                  ]),
                
                SizedBox(
                  height: 15.h,
                ),
                
                 Expanded(
                    child: GridView.count(
                 crossAxisCount: 2,
                  childAspectRatio: 0.6.h,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 5.h,
                  children: products.map((e) {
                    return _buildproductwidget(e, context);
                  }).toList(),
                )),
                
              ]))
    
    
    
    
    
    
    
    
    
    
    ,);
  }
  Widget _buildproductwidget(ProductModel e, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ProductDetails(productModel: e);
            },
          ));
        },
        child: Container(
          padding: EdgeInsets.only(left: 5.h),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E5E5)),
              borderRadius: BorderRadius.all(
                Radius.circular(20.h),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 90.h,
                  width: 90.w,
                  child: CachedNetworkImage(
                    height: 90.h,
                    width: 90.w,
                    imageUrl: e.productimage,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: greencolor,
                    )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              CustomText(
                text: e.productname,
                fontWeight: FontWeight.bold,
                size: 17.sp,
                textalign: TextAlign.right,
              ),
              CustomText(
                text: '1kg ,Price',
                fontWeight: FontWeight.w300,
                size: 17.sp,
                textalign: TextAlign.right,
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _productUtulities.buildsalleWidge(e.sallepourcentage,e.pruductprice),
                    TextButton(
                        onPressed: () {
                          if (context.read<CartBloc>().state.cartitems.contains(e)) {
                            MySnackBar().showSnackBar(
                                context, 'This Product Already Added In Cart');
                          } else{
                                context
                                .read<CartBloc>()
                                .add(AddProduct(productModel: e));
                                MySnackBar().showSnackBar(
                                context, 'Product Added In Cart');
                          }
                       
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: greencolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.h))),
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
  }
}