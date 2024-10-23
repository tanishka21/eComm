import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      print('Firebase Exception in Brand Repository =====>>>>>> $e');
      throw 'Firebase exception';
    } on PlatformException catch (e) {
      print('Platform Exception in Brand Repository =====>>>>>> $e');
      throw 'Firebase exception';
    } catch (e) {
      print('Error in Brands Repository while getting the data $e');
      throw 'Error to get data';
    }
  }

  /// Get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();
      print(
          '====>>>>>>>> Brand id from brand repo in getBrandsForCategory : $brandIds');
      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(1)
          .get();
      print(
          '====>>>>>>>> brand query from brand repo in getBrandsForCategory : $brandsQuery');

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      print(
          '====>>>>>>>> Brands from brand repo in getBrandsForCategory : $brands');

      return brands;
    } on FirebaseException catch (e) {
      print('Firebase Exception in Brand Repository =====>>>>>> $e');
      throw 'Firebase exception';
    } on PlatformException catch (e) {
      print('Platform Exception in Brand Repository =====>>>>>> $e');
      throw 'Firebase exception';
    } catch (e) {
      print('Error in Brands Repository in getBrandsForCategory function $e');
      throw 'Error to get data';
    }
  }
}
