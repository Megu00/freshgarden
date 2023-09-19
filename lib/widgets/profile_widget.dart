

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/utils/constances.dart';
import 'package:fresh_garden/widgets/custom_text.dart';
import 'package:image_picker/image_picker.dart';


import '../blocs/user/bloc/user_bloc.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;


  const ProfileWidget({
    Key? key,
    required this.imagePath,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color,(){
               _buildselectimagedialog(context);
            //  context.read<UserBloc>().add(UpdateImageEvent());
            }),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(getuserimage(imagePath));

    return ClipOval(
      child:imagePath.isNotEmpty?
      
      
      
       Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: const InkWell(),
        ),
      ):Material(
        color: Colors.transparent,
        child: Ink.image(
          image:const AssetImage('assets/nouser_image.png'),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: null
        ),
      )
    );
  }
     _buildselectimagedialog(BuildContext context){
    showDialog(context: context, builder: (context) {
        return AlertDialog(title: const CustomText(text: 'Select Source Image',fontWeight: FontWeight.bold,),
       
       
          content: SizedBox(height: 130.h,width:300.w,
          child: Column(children: [
             InkWell(
              onTap: (){
                context.read<UserBloc>().add(const UpdateImageEvent(imageSource: ImageSource.camera));
                Navigator.pop(context);
              },
               child: Row(
                       children: [
                       CustomText(text: 'Select From Camera',fontWeight: FontWeight.bold,color: greencolor,size: 19.sp,),
                       SizedBox(width: 20.w,),
                       Icon(Icons.camera_alt,size: 22.sp,)
                       ],
                     ),
             ),
             SizedBox(height: 30.h,),
              InkWell(
                onTap: (){
                   context.read<UserBloc>().add(const UpdateImageEvent(imageSource: ImageSource.gallery));
                },
               child: Row(
                       children: [
                       CustomText(text: 'Select From Camera',fontWeight: FontWeight.bold,color: greencolor,size: 19.sp,),
                       SizedBox(width: 20.w,),
                       Icon(Icons.image,size: 22.sp,)
                       ],
                     ),
             )
          ]),
          
          
          
          
          
          ),);
    },);

     }
  Widget buildEditIcon(Color color,Function()? ontap) => InkWell(
    onTap:ontap,
    child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
            color: color,
            all: 8,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
String getuserimage(String fileId) {
    String urlImage =
        'https://cloud.appwrite.io/v1/storage/buckets/64df4f8b3b7947886217/files/$fileId/view?project=64b99872607aa304604e&mode=admin';
    return urlImage;
  }
