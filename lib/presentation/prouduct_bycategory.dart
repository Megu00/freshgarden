import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/blocs.dart';


import 'package:fresh_garden/models/product_model.dart';
import 'package:fresh_garden/presentation/product_details.dart';
import 'package:fresh_garden/widgets/loading_widget.dart';
import 'package:fresh_garden/widgets/show_snackbar.dart';

import '../utils/constances.dart';
import '../widgets/custom_text.dart';

class ProuductByCategory extends StatelessWidget {
  const ProuductByCategory({
    Key? key,
    required this.categoryName,
  }) : super(key: key);
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ErrorLoaded) {
          return const Center(
            child: Text('There IS An Error'),
          );
        }
        if (state is Productloading) {
          return const LoadingWidget();
        }
        if (state is ProductLoaded) {
          final List<ProductModel> products = state.products
              .where((element) => element.productcategory == categoryName)
              .toList();
          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.all(7.h),
                  child: Row(children: [
                    IconButton(
                        onPressed: () {
                        
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: 50.w,
                    ),
                    CustomText(
                      text: categoryName,
                      fontWeight: FontWeight.bold,
                      size: 23.sp,
                      textalign: TextAlign.center,
                    )
                  ]),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7.h,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 5.h,
                  children: products.map((e) {
                    return _buildproductwidget(e, context);
                  }).toList(),
                )),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ));
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
                    CustomText(
                      text: '${e.pruductprice}\$',
                      fontWeight: FontWeight.bold,
                      size: 20.sp,
                      color: blackcolor,
                    ),
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
