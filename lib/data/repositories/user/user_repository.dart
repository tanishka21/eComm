import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
}
