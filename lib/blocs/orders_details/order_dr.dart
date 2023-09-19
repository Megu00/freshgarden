import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fresh_garden/models/order_dmodel.dart';


import '../../database.dart';

class OrderDetailsRepo{
  
  final datatabase=Databases(AppWriteDatabse().client);

  Future<List<OrderDetailsModel>>getorderdetails(String orderId)async{
  return await datatabase.listDocuments(databaseId:'64d8acfd44500a9b43ee',
   collectionId:'64dcfe1d40ffab26168e',queries: [
    Query.equal('orderId', orderId)
   ]
   ).then((DocumentList documentList) {
      return documentList.documents.map((e) => OrderDetailsModel.fromMap(e)).toList();
   });


  }




  
}