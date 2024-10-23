import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/model/category_model.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      print('xcnvuxvhjdbvhdfj===========>>>>>>>>>>>>>$list');
      return list;
    } catch (e) {
      print(
          '================>>>>>>>(Get all Category function) Error in Category_repository ${e.toString()}');
      throw 'Fail to get all categories';
    }
  }

  /// Get sub Categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategorySnapshot = await _db
          .collection('Categories')
          .where('parentId', isEqualTo: categoryId)
          .get();
      final result = subCategorySnapshot.docs
          .map((e) => CategoryModel.fromSnapshot(e))
          .toList();
      print('===>>>>Result of get sub categories $result');
      return result;
    } catch (e) {
      TLoader.errorSnackBar(title: 'OH snap!!!', message: e.toString());
      return [];
    }
  }

  /// Upload Category to the cloud
  Future<void> uploadDummyData(List<CategoryModel> category) async {
    try {
      final storage = Get.put(FirebaseStorageService());

      /// Loop through each category
      for (var categories in category) {
        final file = await storage.getImageDataFromAssets(categories.image);

        final url =
            await storage.uploadImageData('Categories', file, categories.name);

        categories.image = url;
        await _db
            .collection('Categories')
            .doc(categories.id)
            .set(categories.toJson());
      }
    } catch (e) {
      print(
          '================>>>>>>>(Upload Dummy data) Error in Category_repository ${e.toString()}');

      throw 'Error to image update in firebase storage';
    }
  }
}
