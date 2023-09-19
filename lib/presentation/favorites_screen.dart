import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/favorites/bloc/favorites_bloc.dart';

import 'package:fresh_garden/models/favorites_model.dart';
import 'package:fresh_garden/utils/constances.dart';

import '../blocs/favorites/fav_database.dart';

import '../widgets/custom_text.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoritesModel> data = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoritesBloc>(context).add(GetFavoritesEvent());
  }

  Future getdata() async {
    await FavoritesDtatBase.favdb.getdata().then((value) => data = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: SafeArea(
            minimum: EdgeInsets.all(3.h),
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: greencolor,
                    ),
                  );
                }
                if(state is FavoritesErrorState){
                  return Center(child: Text(state.errortext),);
                }
                if (state is FavoritesLoadedState) {
                if(state.favorites.isEmpty){
                  return  Center(child: _buildEmptyfavorites(),);
                }
                  
                  return Column(children: [
                    SizedBox(
                      height: 15.h,
                    ),
           Row(children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_outlined,color: greencolor,)),
            SizedBox(width: 30.w,),
                                CustomText(
                      text: 'Favorites',
                      fontWeight: FontWeight.bold,
                      size: 23.sp,
                    ),
           ],),
                    SizedBox(
                      height: 15.h,
                    ),
                    const Divider(
                      color: Color(0xFFE2E2E2),
                      thickness: 1,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        
                       
                        return _buildcartproduct(state.favorites[index]);
                      },
                    ))
                  ]);
                  
                }
                 return const SizedBox.shrink();
               
              },
            )));
  }

  Widget _buildcartproduct(FavoritesModel favorites) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
      child: ListTile(
        leading:  CachedNetworkImage( height: 90.h,width: 90.w,
        imageUrl:favorites.productimage,
        placeholder: (context, url) => Center(child: CircularProgressIndicator(color: greencolor,)),
        errorWidget: (context, url, error) =>const  Icon(Icons.error),
     ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(
            text: favorites.productname,
            fontWeight: FontWeight.bold,
            size: 22.sp,
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              CustomText(
                text: '1Kg Price',
                fontWeight: FontWeight.w300,
                size: 19.sp,
              ),
              SizedBox(
                width: 23.w,
              ),
              CustomText(
                text: '${favorites.pruductprice}',
                fontWeight: FontWeight.bold,
                size: 22.sp,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ]),
        contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
        trailing: Padding(
            padding: EdgeInsets.only(top: 7.h, left: 3.w),
            child: IconButton(
                onPressed: () async {
                
           context.read<FavoritesBloc>().add(DeletFromFavorites(favId: favorites.productid)); 
            context.read<FavoritesBloc>().add(GetFavoritesEvent());       
                },
                icon: const Icon(Icons.clear))),
      ),
    );
  }
   Widget _buildEmptyfavorites(){
    return Stack(children: [
       SizedBox.expand(child: Column(
          
        children: [
          SizedBox(height: 12.h,),
          Align(alignment: Alignment.topLeft,child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: greencolor,size: 24.sp,)),),
         Image.asset('assets/no_favorites.png'),
         CustomText(text: 'You Have No Favorites Item',fontWeight: FontWeight.bold,color: greencolor,
         size: 20.sp,textalign: TextAlign.center,
         )
       ]),)
    ],);
   }
}
