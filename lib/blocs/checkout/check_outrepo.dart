// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';

import 'package:fresh_garden/models/order_dmodel.dart';

import '../../database.dart';

import '../../models/product_model.dart';

class CheckOutRepo {

  final account = Account(AppWriteDatabse().client);
  final database = Databases(AppWriteDatabse().client);

  Future<String> adduserorder(
      List<ProductModel> cart, Map<String, dynamic> data) async {
    String orderid = '';
    return await account.get().then((account) async {
      if (account.status != false) {
        
        await database
            .createDocument(
                databaseId: '64d8acfd44500a9b43ee',
                collectionId: '64d8ad112dff90fd6a63',
                documentId: ID.unique(),
                data: data)
            .then((document) {
          orderid = document.$id;
        });
      }
      return orderid;
    });
  }

  Future addorderdetails(List<ProductModel> cart, String orderId) async {
    for (var element in cart) {
      final OrderDetailsModel orderDetailsModel = OrderDetailsModel(
          productname: element.productname,
          productprice: element.pruductprice,
          productQuantite: element.productQantite,
          productimage: element.productimage,
          productdesc: element.productdesc,
          productcategory: element.productcategory,
          productorderId: orderId);
      await database.createDocument(
          databaseId: '64d8acfd44500a9b43ee',
          collectionId: '64dcfe1d40ffab26168e',
          documentId: ID.unique(),
          data: orderDetailsModel.toMap()).whenComplete(()async {
      var resule=    await database.getDocument( databaseId: '64cc1740c6fe8db616ed',
      collectionId:'64ff830cba73988b6269', documentId: element.productid);
    int salles=   resule.data['salles'];
            await database.updateDocument( databaseId: '64cc1740c6fe8db616ed',
      collectionId:'64ff830cba73988b6269', documentId: element.productid,data: {
        'salles':salles+element.productQantite
      });
      print('Updattttttted');
          });
    }
  }
}
