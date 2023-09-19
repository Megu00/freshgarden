import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:fresh_garden/models/favorites_model.dart';

import 'package:fresh_garden/utils/constances.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import '../blocs/blocs.dart';

import '../models/product_model.dart';
import '../utils/product_claculate.dart';
import '../utils/rate_dialpg.dart';
import '../widgets/custum_botton.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/show_snackbar.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.productModel});
  final ProductModel productModel;
 
  final MySnackBar _mysnackBar = MySnackBar();
  final ProductUtulities _productUtulities=ProductUtulities();
  @override
  Widget build(BuildContext context) {
   
    final FavoritesModel favoriteModel = FavoritesModel(
        productname: productModel.productname,
        productimage: productModel.productimage,
        pruductprice: double.parse(productModel.pruductprice),
        productcategory: productModel.productcategory,
        productdesc: productModel.productdesc,
        productid: productModel.productid);
    //final double mh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35.h),
                        bottomRight: Radius.circular(35.h))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 22.h,
                            )),
                      ),
                      Center(
                        child: CachedNetworkImage(
                          height: 120.h,
                          width: 120.w,
                          imageUrl: productModel.productimage,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            color: greencolor,
                          )),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ]),
              ),
              Positioned(
                right: 26.w,
                top: 13.h,
                child: IconButton(onPressed: () {
                  context
                      .read<FavoritesBloc>()
                      .add(AddToFavoritesEvent(favoritesModel: favoriteModel));

                  //  FavoritesDtatBase.favdb.ondeletedatabase();
                }, icon: BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    if (state is FavoritesLoadedState) {
                      if (state.favorites.any((element) =>
                              element.productname ==
                              productModel.productname) ==
                          false) {
                        return Icon(
                          Icons.favorite_border_outlined,
                          size: 35.h,
                        );
                      } else {
                        return Icon(
                          Icons.favorite_rounded,
                          color: Colors.redAccent,
                          size: 35.h,
                        );
                      }
                    }
                    return Icon(
                      Icons.favorite_border_outlined,
                      size: 35.h,
                    );
                  },
                )),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: productModel.productname,
                          fontWeight: FontWeight.bold,
                          size: 23.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    ShoRatingDialog().ratingdialoge(context, 00, productModel);
                  },
                  child: RatingBar.builder(
                    initialRating: gettotalerating(productModel.productrating),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 8.h,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                _productUtulities.buildsallewidget2(productModel.sallepourcentage,productModel.pruductprice),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                    height: 210.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFB3B3B3),
                      ),
                      top: BorderSide(
                        color: Color(0xFFB3B3B3),
                      ),
                    )),
                    child: SizedBox(
                      height: 150.h,
                      width: double.maxFinite,
                      child: ListView(children: [
                        Text(
                          productModel.productdesc,
                          style: TextStyle(
                            fontFamily: 'Righteous',
                  
                              fontWeight: FontWeight.w500, fontSize: 18.sp),
                        )
                      ]),
                    )),
                SizedBox(
                  height: 12.h,
                ),
                Center(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return CutomBotton(
                        bottontext: 'Add To Bascket',
                        function: () {
                          if (state.cartitems.contains(productModel)) {
                            _mysnackBar.showSnackBar(
                                context, 'This Product Already In Cart');
                          } else {
                            BlocProvider.of<CartBloc>(context)
                                .add(AddProduct(productModel: productModel));
                            _mysnackBar.showSnackBar(
                                context, 'Product Added In Cart');
                          }
                        },
                        mw: MediaQuery.of(context).size.width - 100,
                      );
                    },
                  ),
                ),
              ],
            ),
          ))
        ],
      )),
    );
  }

  double gettotalerating(List<String> ratings) {
    double productrating = 0;
    List<double> doubleratings = ratings.map((e) => double.parse(e)).toList();

    productrating = doubleratings.reduce((value, element) => value + element) /
        doubleratings.length;
    return productrating;
  }

  String convertdouble(String price, int quantite) {
    return (double.parse(price) * quantite).toStringAsFixed(2);
  }

   
}
