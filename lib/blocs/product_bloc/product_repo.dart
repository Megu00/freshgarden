import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fresh_garden/models/product_model.dart';

import '../../database.dart';
import '../../models/category_model.dart';

class ProductRepo {
  final databases = Databases(AppWriteDatabse().client);

  Future<List<ProductModel>> getproduct() async {
    return await databases
        .listDocuments(
      databaseId: '64cc1740c6fe8db616ed',
      collectionId: '64ff830cba73988b6269',
    )
        .then((value) {
      return value.documents.map((e) => ProductModel.fromJaon(e)).toList();
    });
  }

  Future<List<CategoryModel>> getcategories() async {
    return await databases
        .listDocuments(
            databaseId: '64ce218b4d7c1db65b00',
            collectionId: '64ce2e70416d4c4f2df2')
        .then((DocumentList docs) {
      return docs.documents
          .map((element) => CategoryModel.fromMap(element.data))
          .toList();
    });
  }

  Future<List<ProductModel>> getcategoyproducts(String categoryname) async {
    return await databases.listDocuments(
        databaseId: '64cc1740c6fe8db616ed',
        collectionId: '64cc175a01f790ae857b',
        queries: [Query.equal('productcategory', categoryname)]).then((value) {
      return value.documents.map((e) => ProductModel.fromJaon(e)).toList();
    });
  }

  Future<void> updateproductrating(String productId,List<String>? rating)async{
     databases.updateDocument(databaseId:'64cc1740c6fe8db616ed'
      , collectionId:'64cc175a01f790ae857b', documentId: productId,data: {
         'productRating':rating
      });
  }
  Future<void>getspecifiqueproduct(String productId)async{
      await databases.getDocument(databaseId:'64cc1740c6fe8db616ed'
      , collectionId: '64cc175a01f790ae857b', documentId: productId);
  }
}
