import 'dart:convert';

import 'package:appwrite/models.dart';

class OrderDetailsModel {
  late String productname;
  late String productprice;
  late int productQuantite;
  late String productimage;
  late String productdesc;
  late String productcategory;
 
  
  
  late String productorderId;
  
  OrderDetailsModel({
    required this.productname,
 
    required this.productprice,
    required this.productQuantite,
    required this.productimage,
    required this.productdesc,
    required this.productcategory,
    
    

    required this.productorderId
  });


  Map<String, dynamic> toMap() {
    return {
      'productname': productname,
      'productprice': productprice,
      'productquantite': productQuantite,
      'productimage': productimage,
      'productdesc': productdesc,
      'productcategory': productcategory,
      'orderId':productorderId,
 
    };
  }

  factory OrderDetailsModel.fromMap(Document map) {
    return OrderDetailsModel(
      productname: map.data['productname'],
      productprice: map.data['productprice'],
      productQuantite: map.data['productquantite'],
      productimage: map.data['productimage'],
      productdesc: map.data['productdesc'],
      productcategory: map.data['productcategory'],
    
      productorderId:map.data['orderId']
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) =>
      OrderDetailsModel.fromMap(json.decode(source));





 
 
}
