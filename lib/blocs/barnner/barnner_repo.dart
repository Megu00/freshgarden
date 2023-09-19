import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fresh_garden/database.dart';

class BarnnerRepo {
  Future<List<Document>> getbarrnerList() async {
    final databas = Databases(AppWriteDatabse().client);

    var barnner = await databas.listDocuments(
      databaseId: '64cc1740c6fe8db616ed',
      collectionId: '64fc73f19d32cd135cb9',
    );
    return barnner.documents;
  }
}
