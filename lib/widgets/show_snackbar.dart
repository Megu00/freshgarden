import 'package:flutter/material.dart';

class MySnackBar {
  void showSnackBar(BuildContext context, String info) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(info),behavior: SnackBarBehavior.floating,elevation: 1,
    
    ));
  }
}
