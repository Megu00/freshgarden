
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import '../blocs/cart/bloc/cart_bloc.dart';
import '../blocs/nav_home/bloc/navigation_bloc.dart';
import 'custom_text.dart';

class CustumBottomNav extends StatelessWidget {
  const CustumBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
       final CartBloc cartbloc=context.watch<CartBloc>();
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is Changedindexstate) {
            return BottomNavigationBar(
                currentIndex: state.currentindex,
                elevation: 2,
                onTap: (value) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(Changeindexevent(index: value));
                },
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        height: 35.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Shope'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/explore.svg',
                        height: 35.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Shope'),
                  BottomNavigationBarItem(
                      icon: badges.Badge(
                         badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeContent: CustomText(text: cartbloc.state.cartitems.length.toString(),size: 18.sp,fontWeight: FontWeight.bold,),
    position: badges.BadgePosition.topEnd(),
      child:  SvgPicture.asset(
                        'assets/icons/cart.svg',
                        height: 35.h,
                        width: 35.w,
                      ),),
                      label: 'Shope'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/search.svg',
                        height: 35.h,
                        width: 35.w,
                      ),
                      
                      label: 'Shope'),
                  BottomNavigationBarItem(
                      label: 'Profile',
                      icon: SvgPicture.asset(
                        'assets/icons/user.svg',
                        height: 35.h,
                        width: 35.w,
                      )),
                ]);
          }
          return const SizedBox();
        },
      );
  }
}