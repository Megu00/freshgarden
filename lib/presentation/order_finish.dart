import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/nav_home/bloc/navigation_bloc.dart';
import 'package:fresh_garden/presentation/navigation_home.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import '../blocs/checkout/cubit/chekout_cubit.dart';
import '../widgets/custum_botton.dart';

class OrederFinished extends StatefulWidget {
  const OrederFinished({super.key});

  @override
  State<OrederFinished> createState() => _OrederFinishedState();
}

class _OrederFinishedState extends State<OrederFinished> {
  @override
  void initState() {
    super.initState();
    context.read<NavigationBloc>().add(const Changeindexevent(index: 0));
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return NavigationHome();
          },
        ));
        context.read<ChekoutCubit>().onsteptapp(0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.all(8.h),
            child: Stack(
              children: [
                Image.asset('assets/background.png',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    Image.asset(
                        height: 130.h.h,
                        width: double.infinity,
                        'assets/done.png'),
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Your Order Has Beeen Accepted',
                          fontWeight: FontWeight.bold,
                          size: 26.sp,
                          textalign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text:
                              'Your Items Has Been Placed and is on Its Way Bein Processed',
                          fontWeight: FontWeight.w300,
                          size: 21.sp,
                          textalign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    CutomBotton(
                      bottontext: 'Back To Home',
                      function: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return NavigationHome();
                          },
                        ));
                      },
                      mw: MediaQuery.of(context).size.width - 30.w,
                    )
                  ],
                )
              ],
            )));
  }
}
