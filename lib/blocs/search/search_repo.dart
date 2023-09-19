import 'package:appwrite/appwrite.dart';

import '../../database.dart';
import '../../models/product_model.dart';

class SearchRepo{
final databases = Databases(AppWriteDatabse().client);

  Future<List<ProductModel>> search(String searchtext) async {
    return await databases
        .listDocuments(
      databaseId: '64cc1740c6fe8db616ed',
      collectionId: '64ff830cba73988b6269',
      queries:[
         Query.search('productname', searchtext)
      ]
      
    )
        .then((value) {
      return value.documents.map((e) => ProductModel.fromJaon(e)).toList();
    });
  }




}