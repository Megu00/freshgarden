
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import 'package:fresh_garden/presentation/navigation_home.dart';
import 'package:fresh_garden/presentation/signin_screen.dart';


import '../blocs/authentification/auth_bloc.dart';
import '../blocs/user/bloc/user_bloc.dart';
import '../utils/constances.dart';
import '../widgets/custum_botton.dart';
import '../widgets/custum_textformdield.dart';
import '../widgets/custom_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();
   @override
    void dispose(){
         
  _name.dispose();
  _pass.dispose();
  _email.dispose();
  super.dispose();
 
    }
   
  @override
  Widget build(BuildContext context) {
   // final mh = MediaQuery.of(context).size.height;
    final mw = MediaQuery.of(context).size.width;
    return Scaffold(
        body: BlocConsumer<AuthBloc,AuthState>(builder: (context, state) {
           if (state is LoggedInState) {
     
        return NavigationHome();
      }
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
     

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/background.png', fit: BoxFit.fill),
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
                      padding: EdgeInsets.only(top: 40.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SignUp',
                              style: TextStyle(
                                  fontSize: 25.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            const Text(
                              'enter your condentials yo continu',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: mw,
                        child: CustumTextformfield(
                           textInputType: TextInputType.text,
                          maxLength: 25,
                          redaonly: false,
                          controller: _name,
                          labelText: 'User Name',
                          suffixIcon: const Icon(Icons.person),
                          suffixIconColor: greencolor,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustumTextformfield(
                      maxLength: 30,
                      redaonly: false,
                      controller: _email,
                      labelText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      suffixIcon: const Icon(Icons.check),
                      suffixIconColor: greencolor,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustumTextformfield(
                      textInputType: TextInputType.text,
                      maxLength: 40,
                      redaonly: false,
                      controller: _pass,
                      labelText: 'Password',
                      suffixIcon: const Icon(Icons.remove_red_eye_sharp),
                      suffixIconColor: Colors.black54,
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                    CutomBotton(
                      bottontext: 'SignUp',
                      function: () {
                        BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                            useremail: _email.text, userpass: _pass.text,username: _name.text));
                          context.read<UserBloc>().add(GetuserInfoEvent());  
                          
                   
                      },
                      mw: mw,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: 'You Already Have An Account',
                          size: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                            onTap: () async{
       Navigator.push(context, MaterialPageRoute(builder: (context) {
         return const SignInScreen();
       },));    
         
     
                            },
                            child: CustomText(
                              text: 'SignIN Here',
                              color: greencolor,
                              size: 16.sp,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      );

        }, listener: (context, state) {
          if(state is Errorstate){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errortext)));
          }
        },)
        
      
    
    );
  }
}
