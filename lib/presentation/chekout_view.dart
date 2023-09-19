import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fresh_garden/presentation/order_finish.dart';

import 'package:fresh_garden/utils/constances.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import 'package:fresh_garden/widgets/steps_widgets/adress_step.dart';

import '../blocs/cart/bloc/cart_bloc.dart';
import '../blocs/checkout/cubit/chekout_cubit.dart';
import '../blocs/user/bloc/user_bloc.dart';
import '../models/product_model.dart';

import '../utils/date_timeduction.dart';
import '../widgets/steps_widgets/deliver_step.dart';
import '../widgets/steps_widgets/summary_step.dart';

// ignore: must_be_immutable
class ChekOutView extends StatelessWidget {
  ChekOutView({super.key});

  int index = 0;
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final ConverDate converDate = ConverDate();

  // ProductRepositories _productRepositories = ProductRepositories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ChekoutCubit, ChekoutState>(
      builder: (context, state) {
        if (state is LoadingChekoutstate) {
          return Center(
            child: CircularProgressIndicator(
              color: greencolor,
            ),
          );
        }
        if (state is ChekoutFinshed) {
          return const OrederFinished();
        }

        if (state is LoadedStep) {
          return SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  child: CustomText(
                    text: 'ChekOut',
                    fontWeight: FontWeight.bold,
                    size: 22.sp,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                    child: Stepper(
                        onStepTapped: (value) {
                          BlocProvider.of<ChekoutCubit>(context)
                              .onsteptapp(value);
                        },
                        controlsBuilder: (context, details) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Row(
                              children: [
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLoaded) {
                                      return TextButton(
                                          onPressed: () async {
                                            if (globalKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<ChekoutCubit>(
                                                      context)
                                                  .onstepcontinue(
                                                      context
                                                          .read<CartBloc>()
                                                          .state
                                                          .cartitems,
                                                      {
                                                        'username': state
                                                            .userModel.username,
                                                        'userid': state
                                                            .userModel.userId,
                                                        'useradress':
                                                            '${_state.text}/${_city.text}/${_street.text}',
                                                        'phonenumber':
                                                            _phonenumber.text,
                                                        'datetime':
                                                            DateTime.now()
                                                                .toString(),
                                                        'totaleprice':
                                                            gettotale(context
                                                                        .read<
                                                                            CartBloc>()
                                                                        .state
                                                                        .cartitems)
                                                                    .toInt() +
                                                                50,
                                                      },
                                                      context);
                                            }
                                          },
                                          child: Container(
                                              height: 48.h,
                                              width: 120.w,
                                              decoration: BoxDecoration(
                                                  color: greencolor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.h))),
                                              child: Center(
                                                  child: CustomText(
                                                text:
                                                    BlocProvider.of<ChekoutCubit>(
                                                                    context)
                                                                .currentindex <
                                                            2
                                                        ? 'Next'
                                                        : 'Order Now',
                                                fontWeight: FontWeight.bold,
                                                size: 20.sp,
                                                color: Colors.white,
                                              ))));
                                    }
                                    return const SizedBox.shrink();
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        type: StepperType.horizontal,
                        currentStep:
                            BlocProvider.of<ChekoutCubit>(context).currentindex,
                        steps: [
                      Step(
                          isActive: BlocProvider.of<ChekoutCubit>(context)
                                  .currentindex >=
                              0,
                          state: BlocProvider.of<ChekoutCubit>(context)
                                      .currentindex >=
                                  0
                              ? StepState.complete
                              : StepState.disabled,
                          title: const Text('Page1'),
                          content: AdressStep(
                            city: _city,
                            phonenumber: _phonenumber,
                            state: _state,
                            street: _street,
                            globalKey: globalKey,
                          )),
                      Step(
                          isActive: BlocProvider.of<ChekoutCubit>(context)
                                  .currentindex >=
                              1,
                          state: BlocProvider.of<ChekoutCubit>(context)
                                      .currentindex >=
                                  1
                              ? StepState.complete
                              : StepState.disabled,
                          title: const Text('Page2'),
                          content: const DeliveryStep()),
                      Step(
                          isActive: BlocProvider.of<ChekoutCubit>(context)
                                  .currentindex >=
                              2,
                          state: BlocProvider.of<ChekoutCubit>(context)
                                      .currentindex >=
                                  1
                              ? StepState.complete
                              : StepState.disabled,
                          title: const Text('Summury'),
                          content: SammaryStep(
                            city: _city,
                            phonenumber: _phonenumber,
                            street: _street,
                            userstate: _state,
                          ))
                    ])),
              )
            ],
          ));
        }
        return const SizedBox.shrink();
      },
    ));
  }

  double gettotale(List<ProductModel> cart) {
    return cart.fold(
        00,
        (sum, product) =>
            sum +
            (product.productQantite * double.parse(product.pruductprice)));
  }
}
