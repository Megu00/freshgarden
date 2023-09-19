import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_garden/blocs/blocs.dart';
import 'package:fresh_garden/presentation/cart_screen.dart';
import 'package:fresh_garden/presentation/explore_screen.dart';
import 'package:fresh_garden/presentation/home_screen.dart';
import 'package:fresh_garden/presentation/profile_scree.dart';
import 'package:fresh_garden/presentation/search_page.dart';
import '../widgets/list_bottomNav.dart';
import '../widgets/no_internet_view.dart';


class NavigationHome extends StatelessWidget {
  NavigationHome({super.key});
  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    const CartScreen(),
    const SerachPage(),
   ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: BlocBuilder<ConectivityBloc, ConectivityState>(
        builder: (context, state) {
          if (state is ConectivitySuccess) {
            return BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                if (state is Changedindexstate) {
                  return _screens[state.currentindex];
                }
                return const SizedBox();
              },
            );
          }
          if (state is ConnectivityFail) {
            return const NoInternetView();
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const CustumBottomNav()
    );
  }
 
}
