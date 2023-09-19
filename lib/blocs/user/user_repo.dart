

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../database.dart';
import '../../models/user_model.dart';

class UserRepo{
   final ImageCropper _imageCropper = ImageCropper();

  final ImagePicker _picker = ImagePicker();
    Future updateuserimage(ImageSource imageSource) async {
    final databases = Databases(AppWriteDatabse().client);
    final storage = Storage(AppWriteDatabse().client);
    final account = Account(AppWriteDatabse().client);
    var imagepicked = await _picker.pickImage(source: imageSource);
    if (imagepicked != null) {
      CroppedFile? croppedFile = await cropeimage(imagepicked.path);
      var result = await storage.createFile(
          bucketId: '64df4f8b3b7947886217',
          fileId: ID.unique(),
          file: InputFile.fromPath(path: croppedFile!.path));
      await account.getSession(sessionId: 'current').then((value) async {
        await databases.updateDocument(
            databaseId: '64de28218dd991d1b365',
            collectionId: '64de289866d41f4f30e0',
            documentId: value.userId,
            data: {'userimage': result.$id});
      });
    }
  }
 Future<CroppedFile?> cropeimage(String imagePickedpath) async {
    return await _imageCropper.cropImage(
      sourcePath: imagePickedpath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }
    Future<UserModel> getuserinfo() async {
    final databases = Databases(AppWriteDatabse().client);
    final account = Account(AppWriteDatabse().client);
    final result = await account.get();
    String userId = result.$id;
    return await databases
        .getDocument(
      databaseId: '64de28218dd991d1b365',
      collectionId: '64de289866d41f4f30e0',
      documentId: userId,
    )
        .then((document) {
      UserModel userModel = UserModel.fromMap(document.data);

      return userModel;
    });
  }
Future updattesernfo(Map<String, dynamic> updateuserdata) async {
    final databases = Databases(AppWriteDatabse().client);
    final account = Account(AppWriteDatabse().client);
    await account.getSession(sessionId: 'current').then((value) async {
      await databases.updateDocument(
          databaseId: '64de28218dd991d1b365',
          collectionId: '64de289866d41f4f30e0',
          documentId: value.userId,
          data: updateuserdata);
    });
  }
}