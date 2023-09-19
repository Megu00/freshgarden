

import 'package:appwrite/models.dart';

class ProductModel {
  late String productname;
  late String productimage;
  late String pruductprice;
  late String productcategory;
  late String productdesc;
  int productQantite=1;
  late String productid;
  late List<String> productrating;
  late String dateTime;
  late bool isrecomanded;
  late int salles;
  late int sallepourcentage;

  ProductModel(
      {required this.productname,
      required this.productimage,
      required this.dateTime,
      required this.pruductprice,
      required this.productdesc,
      required this.productcategory,
      required this.productQantite,
      required this.productrating,
      required this.isrecomanded,
      required this.salles,
      required this.sallepourcentage,
      required this.productid});

  ProductModel.fromJaon(Document document) {
    productname = document.data['productname'];
    productcategory = document.data['productcategory'];
    productdesc = document.data['productdescription'];
    pruductprice = document.data['productprice'];
    productimage = document.data['productimage'];
    productrating=List.from(document.data['productRating']);
    dateTime=document.data['datetime'];
    isrecomanded=document.data['isrecomanded'];
    salles=document.data['salles'];
    sallepourcentage=document.data['sallepourcentage'];
  
    productid=document.$id;
  }

  ProductModel copyWith({
     String? productname,
     String? productimage,
    String? pruductprice,
    String? productcategory,
     String? productdesc,
    int? productQantite=1,
   String? productid,
   List <String> ?productrating,
   String ?dateTime,
   bool ?isrecomanded,
   int ?salles,
   int ?sallepourcentage

  }) {
    return ProductModel(
      salles:salles ??this.salles,
      dateTime: dateTime??this.dateTime,
    productname: productname??this.productname,
    productQantite: productQantite??1,
    productcategory: productcategory??this.productcategory,
    productdesc: productdesc??this.productdesc,
    productimage: productimage??this.productimage,
    pruductprice: pruductprice??this.pruductprice,
    productid: productid??this.productid,
   sallepourcentage:sallepourcentage??this.sallepourcentage,
    productrating: productrating??this.productrating,
    isrecomanded: isrecomanded??this.isrecomanded
    );
  }
}
