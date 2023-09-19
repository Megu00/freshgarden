
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_garden/presentation/navigation_home.dart';
import 'package:fresh_garden/presentation/signup_screen.dart';

import '../blocs/authentification/auth_bloc.dart';


class ChekPage extends StatefulWidget {
  const ChekPage({super.key});

  @override
  State<ChekPage> createState() => _ChekPageState();
}
 
class _ChekPageState extends State<ChekPage> {
  @override
  void initState() {
   
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
   //  final account = Account(client);
    return Scaffold(
      body:BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
        if(state is LoggedInState){
          return NavigationHome();
        }
        if(state is ItsnotLoggedInState){
          return const SignupScreen();
        }
        return Container(color: Colors.green,);
      },)
    );
  }
}