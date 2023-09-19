import 'dart:convert';


import 'package:appwrite/models.dart';

class OrderModel {
  late String username;
  late String useradress;
  late String phonenumber;
  late String dateTime;
  late int totalprice; 
  late String userId;
  late String orderDocId;

  OrderModel({
    required this.username,
    required this.useradress,
    required this.phonenumber,
    required this.dateTime,
    required this.totalprice,
    required this.userId,
    required this.orderDocId
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'useradress': useradress,
      'phonenumber': phonenumber,
      'datetime': dateTime,
      'totalprice': totalprice,
      'userid':userId
    };
  }

  factory OrderModel.fromMap(Document map) {
    return OrderModel(
      username: map.data['username'],
      useradress: map.data['useradress'],
      phonenumber: map.data['phonenumber'],
      dateTime: map.data['datetime'],
      totalprice: map.data['totaleprice'],
      userId:map.data['userid'],
      orderDocId: map.$id
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
