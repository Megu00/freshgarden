import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/cart/bloc/cart_bloc.dart';

import 'package:fresh_garden/presentation/chekout_view.dart';

import 'package:fresh_garden/utils/constances.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import '../blocs/checkout/cubit/chekout_cubit.dart';
import '../models/product_model.dart';
import '../widgets/custum_botton.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
 // final ProductRepositories _productRepositories = ProductRepositories();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.all(5.h),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {

              if(state.cartitems.isEmpty){
                return SizedBox(height: double.infinity,width: double.infinity,
              child: Column(children: [
                Image.asset('assets/cart_empty.png'),
              CustomText(text: 'You Have No Items In Your Cart',fontWeight: FontWeight.bold,color: greencolor,size: 22.sp,)
              ],)

                );
              }
              return  Column(children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: 'My Cart',
                          fontWeight: FontWeight.bold,
                          size: 23.sp,
                        ),
                        IconButton(
                            onPressed: () {
              context.read<CartBloc>().add(Clearproducts());  
              context.read<ChekoutCubit>().currentindex=0;       
                            },
                            icon: Icon(
                              Icons.delete_outline_sharp,
                              color: greencolor,size: 22.sp,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(
                      color: Color(0xFFE2E2E2),
                      thickness: 1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/1.5,
                      child: ListView.builder(
                        itemCount: state.cartitems.length,
                        itemBuilder: (context, index) {
                      return _buildcartproduct(
                          state.cartitems[index], context, state.cartitems);
                        },
                      ),
                    ),

         CutomBotton(bottontext: 'Check Out',function: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) {
           return ChekOutView();
         },));
         },mw: MediaQuery.of(context).size.width,)

                  ]);
            },
          )),
    );
  }

  Widget _buildcartproduct(
      ProductModel product, BuildContext context, List<ProductModel> products) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
      child: ListTile(
          leading: CachedNetworkImage(
            height: 90.h,
            width: 90.w,
            imageUrl: product.productimage,
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
              color: greencolor,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
              text: product.productname,
              fontWeight: FontWeight.bold,
              size: 23.sp,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                CustomText(
                  text: '1kg ',
                  fontWeight: FontWeight.w300,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomText(
                  
                  text:convertdouble(product.pruductprice, product.productQantite),
                  
                  fontWeight: FontWeight.bold,
                  size: 23.sp,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _builbottoncart(() {
                
                    BlocProvider.of<CartBloc>(context).add(DecreaseProduct(
                        productid: product.productid,
                        quantite: product.productQantite));
                  
                },
                    const Icon(
                      Icons.remove,
                      color: Color(0xFFE2E2E2),
                    )),
                Padding(
                  padding: EdgeInsets.all(5.h),
                  child: CustomText(
                    fontWeight: FontWeight.bold,
                    text: '${product.productQantite}\$',
                    size: 20.sp,
                  ),
                ),
                _builbottoncart(() {

                  BlocProvider.of<CartBloc>(context).add(IncreaseProduct(
                      productid: product.productid,
                      quantite: product.productQantite ));
                },
                    Icon(
                      Icons.add,
                      color: greencolor,
                    )),
              ],
            ),
          ]),
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
          trailing: Padding(
            padding: EdgeInsets.all(2.h),
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<CartBloc>(context)
                      .add(RemouveProduct(productModel: product));
                },
                icon: const Icon(Icons.clear)),
          )),
    );
  }

  Widget _builbottoncart(VoidCallback fuction, Icon icon) {
    return TextButton(
        onPressed: fuction,
        child: Container(
          height: 35.h,
          width: 35.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(9.h),
              ),
              border: Border.all(color: Colors.black)),
          child: Center(
            child: icon,
          ),
        ));
  }

  double gettotale(List<ProductModel> products) {
    return products
        .fold(
            00,
            (sum, product) => sum + (product.productQantite * double.parse(product.pruductprice)));

          
        
  }
  String convertdouble(String price, int quantite){
  return (double.parse(price)*quantite).toStringAsFixed(2);
  
  
  }
}  
