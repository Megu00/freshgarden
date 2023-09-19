

import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});
  final String _imagename='assets/no-internet.png';
  @override
  Widget build(BuildContext context) {
    final mh=MediaQuery.of(context).size.height;
    final mw=MediaQuery.of(context).size.width;
    return SizedBox.expand(
    child: Center(
      child: Image.asset(height: mh/2,width: mw-80,_imagename),),

    ); 
  }
}