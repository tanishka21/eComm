import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/model/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current order
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();
      print('=================sjnckjdnkjdnkjdnvf==========>>>>>>>Banner repo');
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      print('=============>>>>>>>>>>$e');
      throw 'Error in banner repo';
    }
  }

  /// Upload Banners to the cloud storage

}
