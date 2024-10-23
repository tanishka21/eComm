import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Fetch user address into from the firebase firestore

  Future<List<AddressModel>> fetchUserAddress() async {
    final userId = AuthenticationRepository.instance.authUser!.uid;
    if (userId.isEmpty)
      throw 'Unable to find user information. Try after a moment.';

    final result =
        await _db.collection('Users').doc(userId).collection('Addresses').get();
    print('########## fetch user address in repo $result');
    return result.docs
        .map((documentSnap) => AddressModel.documentSnapshot(documentSnap))
        .toList();
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
      print('------user id $userId');
    } catch (e) {
      throw 'Unable to find Address. Try again.';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      print('^^^^^^ Current Address $currentAddress');
      return currentAddress.id;
    } catch (e) {
      print('^^^^^^^^ Error to update address in addAddress function $e');
      throw 'Something went wrong while updating the address. Try again.';
    }
  }
}
