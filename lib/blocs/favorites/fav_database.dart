import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/favorites_model.dart';

class FavoritesDtatBase {
  final String tablename = 'Favorites';
  final String productId = 'productId';
  final String productname = 'productName';
  final String productdesc = 'productDesc';
  final String productimage = 'productImage';
  final String productPrice = 'productPrice';
  final String prductCategory = 'productCategory';
  FavoritesDtatBase._();
  static final FavoritesDtatBase favdb = FavoritesDtatBase._();
  static Database? _database;

  Future<Database?> get datatbase async {
    if (_database == null) {
      return _database = await initialDb();
    } else {
      return _database;
    }
  }

  Future<Database?> initialDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Saved_Product');
    Database database =
        await openDatabase(path, version: 1, onCreate: creatdatabase);
    return database;
  }

  Future creatdatabase(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tablename($productId TEXT ,
        $productname TEXT NOT NULL,
        $productdesc TEXT NOT NULL,
        $productimage TEXT NOT NULL,
         $productPrice REAL NOT NULL,
         $prductCategory TEXT NOT NULL)''');
    
  }

  Future<List<FavoritesModel>> getdata() async {
    List<Map<String, dynamic>> maps = [];
    Database? mydb = await datatbase;
    maps = await mydb!.query(tablename);
    
    List<FavoritesModel> favorites = [];
    if (maps.isNotEmpty) {
            return favorites = maps.map((e) => FavoritesModel.fromMap(e)).toList();
     
    }

    return favorites;
  }

  Future<int> addtoDtatabase(FavoritesModel favoritesModel) async {
    Database? mydb = await datatbase;
    int response =0;
    await getdata().then((value)async {
     bool isexsist= value.any((element) => element.productid==favoritesModel.productid);
       if(isexsist==true){
        return;
       }else{
        response=   await mydb!.insert(tablename, favoritesModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
       }
    });
  
    
   
    return response;
  }

  Future ondeletedatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Saved_Product');
    await deleteDatabase(path);
  }

  Future<void> deletefavorite(String favid) async {
    Database? mydb = await datatbase;
    await mydb!.delete(tablename,
        where: '$productId=?', whereArgs: [favid]).then((value) {
      
    });
  }
    Future<void>clearfavorites()async{
     Database? mydb = await datatbase;
     await mydb!.delete(tablename);
    }



}
