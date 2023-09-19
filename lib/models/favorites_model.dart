import 'dart:convert';



// ignore_for_file: public_member_api_docs, sort_constructors_first

class FavoritesModel {
  
  late String productname;
   late String productimage;
  
  late double pruductprice;
 
  late String productcategory;
 
  late String productdesc;
 
  late String productid;
  FavoritesModel({
    required this.productname,
    required this.productimage,
    required this.pruductprice,
    required this.productcategory,
    required this.productdesc,
    required this.productid,
  });

  FavoritesModel copyWith({
    String? productname,
    String? productimage,
    double? pruductprice,
    String? productcategory,
    String? productdesc,
    String? productid,
  }) {
    return FavoritesModel(
      productname: productname ?? this.productname,
      productimage: productimage ?? this.productimage,
      pruductprice: pruductprice ?? this.pruductprice,
      productcategory: productcategory ?? this.productcategory,
      productdesc: productdesc ?? this.productdesc,
      productid: productid ?? this.productid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId':productid,
      'productName': productname,
      'productDesc': productdesc,
      'productImage': productimage,
      'productPrice': pruductprice,
      'productCategory': productcategory,
    };
  }

  factory FavoritesModel.fromMap(Map<String, dynamic> map) {
    return FavoritesModel(
      productname: map['productName'],
      productimage: map['productImage'],
      pruductprice: map['productPrice'],
      productcategory: map['productCategory'],
      productdesc: map['productDesc'],
      productid: map['productId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoritesModel.fromJson(String source) =>
      FavoritesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
