import 'dart:ffi';
import 'dart:io';

import 'package:bloc_clean_arch/social_app_tik_tok_like/features/storage/domain/storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;

  /*

     PROFILE PICTURES - upload images to storage 
  
  */
  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImagesMobile(String path, String fileName) {
    return _uploadFile(
      path,
      fileName,
      "profile_images",
    );
  }

  /*

     POSTS PICTURES - upload images to storage 
  
  */

  //post pictures upload for web
  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, "profile_posts");
  }

  //post pictures upload for mobile
  @override
  Future<String?> uploadPostImagesMobile(String path, String fileName) {
    return _uploadFile(
      path,
      fileName,
      "profile_post",
    );
  }

  /*
 HELPER METHODS - to upload files to storage 
 */

//mobile platforms (file)
  Future<String?> _uploadFile(
      String path, String fileName, String folder) async {
    try {
      //get file
      final file = File(path);

      //find place to store
      final storageRef = storage.ref().child('$folder/$fileName');

      final uploadTask = await storageRef.putFile(file);

      // get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

//web platform
  Future<String?> _uploadFileBytes(
      Uint8List fileBytes, String fileName, String folder) async {
    try {
      //find place to store
      final storageRef = storage.ref().child('$folder/$fileName');

      final uploadTask = await storageRef.putData(fileBytes);

      // get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
