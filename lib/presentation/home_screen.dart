import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/blocs.dart';
import 'package:fresh_garden/models/product_model.dart';
import 'package:fresh_garden/presentation/see_AllCollection.dart';
import 'package:fresh_garden/widgets/loading_widget.dart';

import 'package:fresh_garden/widgets/custom_text.dart';

import '../utils/constances.dart';
import '../utils/date_timeduction.dart';
import '../utils/navigation.dart';
import '../widgets/barnner_widget.dart';
import '../widgets/products_home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ConverDate _converDate = ConverDate();
  final Navigation _navigation=Navigation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.all(8.h),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is Productloading) {
                return const LoadingWidget();
              }
              if (state is ProductLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return CustomText(
                            text: 'Hi ${state.userModel.username}',
                            fontWeight: FontWeight.bold,
                            size: 20.sp,
                            textalign: TextAlign.center,
                          );
                        }
                        if (state is UserLoadingState) {
                          return const SizedBox.shrink(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const Text('');
                      },
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    const CarouselWidget(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Exclusive Offer',
                          fontWeight: FontWeight.bold,
                          size: 20.sp,
                        ),
                       _buildnavigationTocollection('Exclusive Offer',
                        _navigation, context,state.products
                            .where((element) => element.sallepourcentage != 0)
                            .toList() )
                      ],
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    ProductsHome(
                        products: state.products
                            .where((element) => element.sallepourcentage != 0)
                            .toList().sublist(0,3)),
                             SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Recomanded For You',
                          fontWeight: FontWeight.bold,
                          size: 20.sp,
                        ),
                       _buildnavigationTocollection(
                        'Recomanded For You',_navigation,context,
                        _ortBestSellingList(state.products
                                .where((element) => element.isrecomanded)
                                .toList())
                       )
                      ],
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    ProductsHome(
                        products: _ortBestSellingList(state.products
                                .where((element) => element.isrecomanded)
                                .toList())
                            .sublist(0, 4)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Best Selling',
                          fontWeight: FontWeight.bold,
                          size: 20.sp,
                        ),
                       _buildnavigationTocollection('Best Selling',_navigation, context,
                       _ortBestSellingList(state.products.sublist(0,7)
                                
                                .toList()) )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ProductsHome(
                        products: _ortBestSellingList(state.products
                               
                                .toList())
                            .sublist(0, 4)),
                             SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Check Our New Product',
                          fontWeight: FontWeight.bold,
                          size: 20.sp,
                        ),
                         _buildnavigationTocollection('Best Selling',_navigation, context,
                       state.products
                            .where((element) => DateTime.parse(element.dateTime)
                                .isAfter(_converDate.durationNewproducts()))
                            .where((element) => element.sallepourcentage == 0)
                            .toList()
                                
                             )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ProductsHome(
                        products: state.products
                            .where((element) => DateTime.parse(element.dateTime)
                                .isAfter(_converDate.durationNewproducts()))
                            .where((element) => element.sallepourcentage == 0)
                            .toList()),
                  ]),
                );
              }
              return  Center(
                child: CustomText(text: 'Loading',fontWeight: FontWeight.bold,size: 20.sp,)
              );
            },
          )),
    );
  }
   Widget _buildnavigationTocollection(String collectionName,Navigation navigation ,BuildContext context,List<ProductModel>products){
  return  GestureDetector(onTap: (){
    navigation.pushmethod(context, SeeAll(productCollection:collectionName ,products: products,));
    },
    child: CustomText(
                          text: 'See all',
                          fontWeight: FontWeight.bold,
                          size: 17.sp,
                          color: greencolor,
                        ),
    
    );
    }
  List<ProductModel> _ortBestSellingList(List<ProductModel> prodcts) {
    prodcts.sort(
      (a, b) => b.salles.compareTo(a.salles),
    );
    return prodcts;
  }
}
