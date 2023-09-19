import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;


import 'package:shared_preferences/shared_preferences.dart';

import '../../database.dart';
import '../../models/user_model.dart';

class AuthRepositories {

  SharedPreferences _sharedPreferences;
  AuthRepositories({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  Future<bool> registeruser(
      String useremail, String userpass, String username) async {
    final account = Account(AppWriteDatabse().client);
    bool status = false;
    _sharedPreferences = await SharedPreferences.getInstance();
    var user = await account.create(
      userId: ID.unique(),
      email: useremail,
      password: userpass,
    );
    // ignore: unrelated_type_equality_checks
    if (user != false) {
      status = true;

      _sharedPreferences.setBool('status', status);

      await account
          .createEmailSession(email: useremail, password: userpass)
          .whenComplete(() async {
        UserModel userModel = UserModel(
            username: username,
            useremail: user.email,
            userpass: userpass,
            userimage: '',
            userbirthday: '',
            usergendre: 'notyet',
            userphone: '',
            userId: user.$id);
        await saveuserdata(userModel);
      });
    }

    return status;
  }

  Future<bool> signInuser(String useremail, String userpass) async {
    final account = Account(AppWriteDatabse().client);
    _sharedPreferences = await SharedPreferences.getInstance();
    bool status = false;

    await account
        .createEmailSession(email: useremail, password: userpass)
        .then((value) {
      if (value.current != false) {
        status = true;
        _sharedPreferences.setBool('status', status);
      }
    });
    return status;
  }

  Future<dynamic> logout() async {
    final account = Account(AppWriteDatabse().client);
    _sharedPreferences = await SharedPreferences.getInstance();
    account.deleteSession(sessionId: 'current');
    _sharedPreferences.setBool('status', false);
  }

  Future<bool> cheklogin() async {
    final account = Account(AppWriteDatabse().client);
    bool status = false;
    model.Session session = await account.getSession(sessionId: 'current');

    status = session.current;
    return status;
  }

  Future saveuserdata(UserModel userModel) async {
    final databases = Databases(AppWriteDatabse().client);
    await databases.createDocument(
        databaseId: '64de28218dd991d1b365',
        collectionId: '64de289866d41f4f30e0',
        documentId: userModel.userId,
        data: userModel.toMap());
  }





  

 
}
