
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/orders_details/bloc/order_details_bloc.dart';
import 'package:fresh_garden/models/order_dmodel.dart';

import 'package:fresh_garden/utils/constances.dart';

import '../../utils/date_timeduction.dart';
import '../../utils/product_claculate.dart';
import '../../widgets/custom_text.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails(
      {super.key, required this.orderId, required this.details});
  final String orderId;
  final Map<String, dynamic> details;
  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  void initState() {
    context
        .read<OrderDetailsBloc>()
        .add(Getorderdetails(orderId: widget.orderId));
    super.initState();
  }

 final ConverDate _converDate = ConverDate();
  final ProductUtulities _productUtulities = ProductUtulities();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
      builder: (context, state) {
        if (state is OrderDetailsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: greencolor,
            ),
          );
        }
        if (state is OrderDetailsError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (state is OrderDetailsLoaded) {
          Map<String, dynamic> details = widget.details;
          return SafeArea(
              minimum: EdgeInsets.all(8.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          )),
                      CustomText(
                        text: 'Orders Details',
                        fontWeight: FontWeight.bold,
                        size: 23.sp,
                        textalign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 1.6,
                      width: double.infinity,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return _buildordersdetailscard(
                                state.orderdetails[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 12.h,
                            );
                          },
                          itemCount: state.orderdetails.length)),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              'You Will Receive Your Orders btween ${_converDate.converDateOrder(details['order time'])} and ${_converDate.getdateofDelivery(details['order time'])}',
                          fontWeight: FontWeight.bold,
                          size: 18.sp,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomText(
                          text: details['user adress'],
                          fontWeight: FontWeight.w300,
                          size: 18.sp,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Totale Amount: ',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300)),
                            TextSpan(
                                text: '${details['totale Price']} \$',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400))
                          ]),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomText(
                          text: 'Phone Number:${details['user phone']}',
                          fontWeight: FontWeight.w300,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ))
                ],
              ));
        }
        return const SizedBox.shrink();
      },
    ));
  }

  Widget _buildordersdetailscard(
    OrderDetailsModel orderDetailsModel,
  ) {
    return Container(
        height: 140.h,
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
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 90.w,
              color: greycolor.withOpacity(0.7),
              child: CachedNetworkImage(
                height: 90.h,
                width: 90.w,
                imageUrl: orderDetailsModel.productimage,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: greencolor,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: orderDetailsModel.productname,
                        fontWeight: FontWeight.bold,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                     
                      SizedBox(
                        width: 10.w,
                      ),
                 //     TextButton(
                 //         onPressed: () {},
                 //         child: CustomText(
                  //          text: 'Details',
                  //          fontWeight: FontWeight.w400,
                  //          color: greencolor,
                  //          size: 15.sp,
                   //       ))
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: 'Quantite: ${orderDetailsModel.productQuantite}',
                    fontWeight: FontWeight.w300,
                    size: 20.sp
                    
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(text:  'Price: ${_productUtulities.convertdouble(orderDetailsModel.productprice, orderDetailsModel.productQuantite)}\$',
                  fontWeight: FontWeight.bold,size: 19.sp,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
