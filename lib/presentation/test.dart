import 'package:appwrite/appwrite.dart';

import 'package:flutter/material.dart';


import 'package:fresh_garden/models/category_model.dart';
import 'package:fresh_garden/models/order_model.dart';

import 'package:fresh_garden/repositories/product_repo.dart';



class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<CategoryModel> categories = [];
  List test = [];
  final ProductRepositories productRepositories = ProductRepositories();

  //final  OrdersRepo _ordersRepo=OrdersRepo();
  List<OrderModel> orders = [];
  //final CheckOutRepo _checkOutRepo=CheckOutRepo();
  List<int> numbers = [10, 20, 30, 40, 50];
  List<dynamic> favorits = [];

  Future readtest() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: IconButton(
              onPressed: () async {

              },
              icon: const Icon(Icons.done)),
          leading: IconButton(
              onPressed: () async {
                
              },
              icon: const Icon(Icons.add)),
        ),
        body: Center(child:IconButton(onPressed: ()async{
            Client client = Client()
                    .setEndpoint('https://cloud.appwrite.io/v1')
                    .setProject('64b99872607aa304604e')
                    .setSelfSigned();
            final Account account=Account(client);
            await account.createOAuth2Session(provider:'facebook').then((value) {
             
            });  
        }, icon: const Icon(Icons.add)),)
        
        
        
        
        
        
        );
  }
}
