import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/models/user_model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// FUnction to save the user data to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      print('Started to set the collection');
      await _db.collection("Users").doc(user.id).set(
            user.toJson(),
          );
      print('Done with collection');
    } catch (e) {
      print('=============>>>>>>>>>>>>>>${e.toString()}');
      throw 'Failed to save user==============>>>>>>>>> ${e}';
    }
  }

  ///Function to fetch user details based on user ID.

  Future<UserModel> fetchUserDetails() async {
    try {
      print('Fetching user data===>>>>>>>>>>>..');
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        ///fromSnapshot function is created in Usermodel
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      print('=============>>>>>>>>>>>>>>${e.toString()}');
      throw 'Failed to Fetch users Details==============>>>>>>>>> ${e}';
    }
  }

  ///FUnction to update user data in firestore

  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      print('Started to update user details');
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
      print('User Details updated');
    } catch (e) {
      print('=============>>>>>>>>>>>>>>${e.toString()}');
      throw 'Failed to update user Details==============>>>>>>>>> ${e}';
    }
  }

  ///Update any field in specific Users Collection

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      print('Started to update single fields');
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
      print('User single field updated');
    } catch (e) {
      print('=============>>>>>>>>>>>>>>${e.toString()}');
      throw 'Failed to update user field==============>>>>>>>>> ${e}';
    }
  }

  ///FUnction to remove user data from Firestore

  Future<void> removeUserRecord(String userId) async {
    try {
      print('Started to delete the user record');
      await _db.collection("Users").doc(userId).delete();
      print('User data removed');
    } catch (e) {
      print('=============>>>>>>>>>>>>>>${e.toString()}');
      throw 'Failed to remove user==============>>>>>>>>> ${e}';
    }
  }

  ///Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      print('uploadImage function');
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'Fail to upload image';
    }
  }
}
