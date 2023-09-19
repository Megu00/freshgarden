import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fresh_garden/presentation/favorites_screen.dart';
import 'package:fresh_garden/presentation/edit_profile.dart';

import 'package:fresh_garden/presentation/orders/orders_view.dart';

import 'package:fresh_garden/presentation/signup_screen.dart';
import 'package:fresh_garden/utils/constances.dart';
import 'package:fresh_garden/widgets/custom_text.dart';

import '../blocs/authentification/auth_bloc.dart';
import '../blocs/user/bloc/user_bloc.dart';
import '../utils/dailogue.dart';
import '../utils/navigation.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
final Navigation _navigation=Navigation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is ItsnotLoggedInState) {
          return  const SignupScreen();
        }

        return SafeArea(
            minimum: EdgeInsets.only(left: 3.w, right: 3.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 12.w,
                          ),
                          SizedBox(
                            height: 70.h,
                            width: 70.w,
                            child: CircleAvatar(
                              radius: 29.h,
                              backgroundColor: Colors.transparent,
                              
                              child: state.userModel.userimage.isEmpty
                                  ? const SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage('assets/nouser_image.png'),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: getuserimage(
                                        state.userModel.userimage,
                                      ),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: double.infinity - 20.h,
                                        width: double.infinity - 20.w,
                                        decoration: BoxDecoration(
                                          color: greycolor.withOpacity(0.7),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        color: greencolor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: state.userModel.username,
                                fontWeight: FontWeight.bold,
                                size: 20.sp,
                              ),
                              CustomText(
                                text: state.userModel.useremail,
                                fontWeight: FontWeight.w300,
                                size: 19.sp,
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink(
                      child: Text('Error'),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
               _buildlisttile(
                    'Orders', SvgPicture.asset('assets/icons/orders.svg', height: 35.h,
                      width: 35.w,), () {
                 _navigation.pushmethod(context, const OrdersView());
                }),
                _buildlisttile(
                    'My Favorittes',
                    SvgPicture.asset(
                      'assets/icons/favorite.svg',
                      height: 35.h,
                      width: 35.w,
                    ), () {
                 _navigation.pushmethod(context,const FavoritesScreen());
                }),
                _buildlisttile(
                    'Edit Profile', SvgPicture.asset('assets/icons/settings.svg', height: 35.h,
                      width: 35.w,), () {
                 _navigation.pushmethod(context,const EditProfile());
                }),
               _buildlisttile(
                    'About', SvgPicture.asset('assets/icons/about.svg', height: 35.h,
                      width: 35.w,), () {
                
                }),
                SizedBox(height: 100.h,),
                TextButton(
                    onPressed: () {
                      Dialogs().showdialogue(context);
                    },
                    child: Container(
                        height: 45.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: greycolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.h))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            const Icon(Icons.logout),
                            SizedBox(
                              width: 90.w,
                            ),
                            Center(
                                child: CustomText(
                              text: 'Log Out',
                              fontWeight: FontWeight.bold,
                              color: greencolor,
                              size: 19.sp,
                            ))
                          ],
                        )))
              ],
            ));
      },
      listener: (context, state) {
        if (state is Errorstate) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errortext)));
        }
      },
    ));
  }

  Widget _buildlisttile(
      String title, Widget iconData, VoidCallback voidCallback) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: greycolor),
          bottom: BorderSide(color: greycolor),
        )),
        child: ListTile(
          contentPadding: EdgeInsets.all(6.h),
          leading: iconData,
          title: CustomText(
            text: title,
            fontWeight: FontWeight.bold,
            size: 20.sp,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }

  String getuserimage(String fileId) {
    String urlImage =
        'https://cloud.appwrite.io/v1/storage/buckets/64df4f8b3b7947886217/files/$fileId/view?project=64b99872607aa304604e&mode=admin';
    return urlImage;
  }
}
