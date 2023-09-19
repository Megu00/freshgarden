import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fresh_garden/presentation/navigation_home.dart';
import 'package:fresh_garden/presentation/signup_screen.dart';

import '../blocs/authentification/auth_bloc.dart';

import '../utils/constances.dart';
import '../widgets/custom_text.dart';

import '../widgets/custum_textformdield.dart';

class SignInScreen extends StatefulWidget {
 const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _pass = TextEditingController();

  final TextEditingController _email = TextEditingController();
 @override 
 void dispose(){
  _email.dispose();
  _pass.dispose();
  super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    //  final mh=MediaQuery.of(context).size.height;
    //   final mw=MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.all(5.h),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: greencolor,
              ),
            );
          }

          if (state is LoggedInState) {
            
            return NavigationHome();
          }
             
          return BlocListener<AuthBloc,AuthState
          >(
              listener: (context, state) {
                if (state is Errorstate) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.errortext)));
                }
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/background.png',
                          fit: BoxFit.fill),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.all(17.h),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 80.h),
                                child: SizedBox(
                                  height: 50.h,
                                  width: 50.w,
                                  child: Image.asset('assets/carrot.png'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SignIn',
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      const Text(
                                        'enter your condentials yo continu',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustumTextformfield(
                                maxLength: 13,
                                redaonly: false,
                                controller: _email,
                                labelText: 'Email',
                                suffixIcon: const Icon(Icons.check),
                                suffixIconColor: greencolor,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustumTextformfield(
                                redaonly: false,
                                maxLength: 13,
                                controller: _pass,
                                labelText: 'User Name',
                                suffixIcon:
                                    const Icon(Icons.remove_red_eye_sharp),
                                suffixIconColor: Colors.black54,
                              ),
                              SizedBox(
                                height: 55.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        SignInEvent(
                                            useremail: _email.text,
                                            userpass: _pass.text));
                                            
                                  },
                                  child: const Text('test')),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: 'You Don t Have An Account',
                                    size: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(width: 13.w),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const SignupScreen();
                                          },
                                        ));
                                      },
                                      child: CustomText(
                                        text: 'SignUp Here',
                                        color: greencolor,
                                        size: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ])));
        },
      ),
    ));
  }
}
