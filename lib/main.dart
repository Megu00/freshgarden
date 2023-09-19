import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_garden/blocs/barnner/barnner_repo.dart';
import 'package:fresh_garden/blocs/barnner/bloc/barnner_bloc.dart';
import 'package:fresh_garden/blocs/cart/bloc/cart_bloc.dart';
import 'package:fresh_garden/blocs/conectivity/bloc/conectivity_bloc.dart';

import 'package:fresh_garden/blocs/favorites/bloc/favorites_bloc.dart';
import 'package:fresh_garden/blocs/favorites/fav_database.dart';

import 'package:fresh_garden/blocs/orders_details/bloc/order_details_bloc.dart';
import 'package:fresh_garden/blocs/orders_details/order_dr.dart';
import 'package:fresh_garden/blocs/product_bloc/category_bloc/bloc/category_bloc.dart';

import 'package:fresh_garden/blocs/product_bloc/product_repo.dart';

import 'package:fresh_garden/blocs/authentification/auth_repositories.dart';
import 'package:fresh_garden/blocs/search/bloc/search_bloc.dart';
import 'package:fresh_garden/blocs/search/search_repo.dart';

import 'package:fresh_garden/presentation/splash_scree.dart';

import 'package:fresh_garden/utils/constances.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/authentification/auth_bloc.dart';
import 'blocs/checkout/check_outrepo.dart';
import 'blocs/checkout/cubit/chekout_cubit.dart';
import 'blocs/nav_home/bloc/navigation_bloc.dart';
import 'blocs/orders/bloc/orders_bloc.dart';
import 'blocs/orders/order_repo.dart';
import 'blocs/product_bloc/product_bloc/product_bloc.dart';
import 'blocs/user/bloc/user_bloc.dart';
import 'blocs/user/user_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({
    Key? key,
    required this.prefs,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<BarnnerBloc>(
                create: (context) => BarnnerBloc(barnnerRepo: BarnnerRepo())..add(GetBarnnerEvent()),
              ),
              BlocProvider<SearchBloc>(
                create: (context) => SearchBloc(searchRepo: SearchRepo()),
              ),
              BlocProvider<ConectivityBloc>(
                create: (context) =>
                    ConectivityBloc()..add(CheckConnectivity()),
              ),
              BlocProvider<FavoritesBloc>(
                  create: (context) => FavoritesBloc(
                        favoritesDtatBase: FavoritesDtatBase.favdb,
                      )..add(GetFavoritesEvent())),
              BlocProvider<UserBloc>(
                  create: (context) => UserBloc(
                        userRepo:UserRepo()
                           
                      )..add(GetuserInfoEvent())),
              BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(
                      userBloc: BlocProvider.of<UserBloc>(context),
                      authRepositories:
                          AuthRepositories(sharedPreferences: prefs),
                      sharedPreferences: prefs)
                    ..add(Chekevent())),
              BlocProvider(
                  create: (context) => OrderDetailsBloc(OrderDetailsRepo())),
              BlocProvider<OrdersBloc>(
                create: (context) => OrdersBloc(OrdersRepo()),
              ),
              BlocProvider<CartBloc>(create: (context) => CartBloc()),
              BlocProvider(
                create: (context) => ChekoutCubit(
                    cartBloc: BlocProvider.of<CartBloc>(context),
                    checkOutRepo: CheckOutRepo()),
              ),
              BlocProvider<CartBloc>(create: (context) => CartBloc()),
              BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(ProductRepo())..add(GetcategoryEvent()),
              ),
              BlocProvider<ProductBloc>(
                create: (context) =>
                    ProductBloc(productRepo: ProductRepo())..add(Getproduct()),
              ),
              BlocProvider<NavigationBloc>(
                create: (context) => NavigationBloc(),
              ),
            ],
            child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                    colorScheme: ColorScheme.light(primary: greencolor)),
                home: const SplashScreeen()));
      },
    );
  }
}
