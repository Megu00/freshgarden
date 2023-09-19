


import 'package:fresh_garden/database.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;


import '../../models/order_model.dart';


class OrdersRepo {

    final account = Account(AppWriteDatabse().client);
 Future<List<OrderModel>>getorders()async{
  
 return  account.getSession(sessionId: 'current').then((value) async{
       final database=Databases(AppWriteDatabse().client);
   return await database.listDocuments(databaseId:'64d8acfd44500a9b43ee' 
   , collectionId:'64d8ad112dff90fd6a63',queries: [
      Query.equal('userid', value.userId)
   ]
   
   
   ).then((model.DocumentList documentList) {
      return documentList.documents.map((e) => OrderModel.fromMap(e)).toList();
   });
   });








 }



}