import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fresh_garden/presentation/orders/order-d_view.dart';
import 'package:fresh_garden/utils/constances.dart';
import 'package:fresh_garden/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import '../../blocs/orders/bloc/orders_bloc.dart';
import '../../models/order_model.dart';
import '../../utils/navigation.dart';


class OrdersView extends StatefulWidget {
  const OrdersView({super.key,});
  
  @override
  State<OrdersView> createState() => _OrdersViewState();
}
  
class _OrdersViewState extends State<OrdersView> {
   // final ProductCalculate _productCalculate=ProductCalculate();

  @override
  void initState() {
    context.read<OrdersBloc>().add(GetOrders());
    super.initState();
  }

  final Navigation _navigation=Navigation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(minimum: EdgeInsets.all(9.h),
            child: Column(
              
      children: [
        SizedBox(height: 11.h,),
        Row(
          children: [
               SizedBox(width: 7.w,),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                )),
                SizedBox(width: 7.w,),
            CustomText(
              text: 'Orders',
              fontWeight: FontWeight.bold,
              size: 23.sp,
              textalign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Expanded(child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: greencolor,
                ),
              );
            }
            if (state is ErrorOrdersState) {
              return const Center(
                child: Text('SomeThing Wrong'),
              );
            }
            
            if (state is OrdersLoadedState) {
              if(state.orders.isEmpty){

                return SizedBox(height: double.infinity,width: double.infinity,
              child: Column(children: [
                Image.asset('assets/cart_empty.png'),
              CustomText(text: 'You Have No Order',fontWeight: FontWeight.bold,color: greencolor,size: 22.sp,)
              ],)

                );
            
                
                  
              }

              return SizedBox(height: double.infinity,width: double.infinity,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
               
                        return _buildcardorders(state.orders[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 12.h,
                        );
                      },
                      itemCount: state.orders.length));
            }

            return const SizedBox.shrink();
          },
        ))
      ],
    )));
  }

  Widget _buildcardorders(OrderModel orderModel) {
    return Container(
      

      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFffffff),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0.h, // soften the shadow
              spreadRadius: 1.0.h, //extend the shadow
              offset: Offset(
                1.5.h, // Move to right 5  horizontally
                1.5.h, // Move to bottom 5 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(5.h))),
      padding: EdgeInsets.all(10.h),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'User Name:',
                  fontWeight: FontWeight.bold,
                  size: 19.sp,
                ),
                SizedBox(
                  width: 6.w,
                ),
                FittedBox(fit: BoxFit.contain,
                
                  child: CustomText(
                    size: 19.sp,
                    text: orderModel.username,
                    fontWeight: FontWeight.w300,
                    
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                CustomText(
                  text: 'Adress:',
                  fontWeight: FontWeight.bold,
                  size: 19.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
          Expanded(
            child: CustomText(
                              text: orderModel.useradress,
                              fontWeight: FontWeight.w400,
                              size: 19.sp,
                            ),
          )
                
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                CustomText(
                  text: 'Order At',
                  fontWeight: FontWeight.bold,
                  size: 19.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: DateFormat.yMd().format(DateTime.parse(orderModel.dateTime)),
                  fontWeight: FontWeight.w400,
                  size: 18.sp,
                ),
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                CustomText(
                  text: 'Totale Price: ',
                  fontWeight: FontWeight.bold,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: '${orderModel.totalprice}\$',
                  fontWeight: FontWeight.w400,
                  size: 18.sp,
                ),
              ],
            ),
            Row(
              children: [
                CustomText(
                  text: 'Payments Method',
                  fontWeight: FontWeight.bold,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: '15/08/2023',
                  fontWeight: FontWeight.w400,
                  size: 18.sp,
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  Map <String,dynamic>details={
                        'totale Price':orderModel.totalprice,
                         'user adress':orderModel.useradress,
                         'order time':orderModel.dateTime,
                         'user phone':orderModel.phonenumber
                      };
              _navigation.pushmethod(context,OrdersDetails(
                                orderId: orderModel.orderDocId,details: details,
                              ) );
                              
                 
                },
                child: CustomText(
                  text: 'Details',
                  fontWeight: FontWeight.bold,
                  size: 20.sp,
                ))
          ]),
    );
  }
    

}
