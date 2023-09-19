import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

import '../blocs/user/bloc/user_bloc.dart';
import '../database.dart';
import '../utils/constances.dart';
import '../widgets/custom_text.dart';
import '../widgets/custum_botton.dart';
import '../widgets/custum_textformdield.dart';
import '../widgets/profile_widget.dart';

class EditProfile extends StatefulWidget {
 const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _birthday = TextEditingController();

  final account = Account(AppWriteDatabse().client);
  @override
  void dispose(){
   _name.dispose();
   _phone.dispose();
   _birthday.dispose();
     super.dispose();
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String ? valuedrob;
  final List<String> _value = ['man', 'woman'];
  @override
  Widget build(BuildContext context) {
    
  
    final mw = MediaQuery.of(context).size.width;
    return Scaffold(body: BlocBuilder<UserBloc, UserState>(
     
      
      builder: (context, state) {

   if(state is UserLoadingState){
       if(state.islaoding==true){
        return Center(child: CircularProgressIndicator(color: greencolor,),);
       }
   }

        if (state is UserLoaded) {
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
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                        Row(children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon:const Icon(Icons.arrow_back_ios_new)),
                        SizedBox(width: 4.w,),
                                                  CustomText(
                            text: 'Edit Profile',
                            fontWeight: FontWeight.bold,
                            size: 24.sp,
                          ),

                        ],),
                          SizedBox(
                            height: 25.h,
                          ),
                          ProfileWidget(
                            imagePath:
                               state.userModel.userimage,
                           
                          ),
                          SizedBox(
                              width: mw,
                              child: CustumTextformfield(
                                 textInputType: TextInputType.text,
                                controller: _name,
                                maxLength: 13,
                                redaonly: false,
                                labelText: 'Name',
                                suffixIcon: const Icon(Icons.person),
                                suffixIconColor: greencolor,
                              )),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustumTextformfield(
                           
                            maxLength: 10,
                            redaonly: false,
                            controller: _phone,
                            textInputType: TextInputType.phone,
                            labelText: 'Phone',
                            suffixIcon: const Icon(Icons.check),
                            suffixIconColor: greencolor,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustumTextformfield(
                            controller: _birthday,
                          maxLength: 20,
                            redaonly: true,
                            labelText: 'BirthDay',
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  _birthday.text =
                                      await updateuserbirthday(context);
                                },
                                icon: Icon(
                                  Icons.date_range_outlined,
                                  color: greencolor,
                                )),
                            suffixIconColor: Colors.black54,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            
                            child:
                             DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                itemHeight: 50.h,
                                isExpanded: true,
                               hint:  CustomText(text: 'Selecte Gendre',fontWeight: FontWeight.bold,size: 19.sp,),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.h)),
                                  value: valuedrob,
                                  items: _value
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child:Row(
                                              children: [
                           Icon(item=='man'?Icons.man:Icons.woman) ,
                        
                        
                        SizedBox(width: 3.w,),
                           CustomText(text: item,fontWeight: FontWeight.bold,size: 19.sp,)                    
                                              ],
                                            )
                                          ))
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      valuedrob = value!;
                                    
                                     
                                    });
                                  }),
                            ),
                          ),
                           SizedBox(
                            height: 40.h,
                          ),
                          CutomBotton(
                            bottontext: 'Save',
                            function: () async {
                              if (_key.currentState!.validate()) {
                                
                                try {
                                  context
                                      .read<UserBloc>()
                                      .add(UpdateUserInfo(updateUserdata: {
                                        'username': _name.text,
                                        'usergendre': valuedrob,
                                        'userphone': _phone.text,
                                        'userbirthday': _birthday.text
                                      }));
                                    
                                                                    } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                            },
                            mw: mw,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          );
        }
        return const SizedBox.shrink();
      },
    ));
  }

  

  Future<String> updateuserbirthday(BuildContext context) async {
    String userbirthday = '';
    var datetime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2090));
    if (datetime != null) {
      userbirthday = DateFormat.yMMMMd().format(datetime);
    }
    return userbirthday;
  }
}
