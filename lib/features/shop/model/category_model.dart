import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  /// Empty helper function
  static CategoryModel empty() => CategoryModel(
      id: '', name: '', image: '', isFeatured: false, parentId: '');

  /// Convert model to Json structure so that we can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from firebase to usermodel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      /// Map JSON Record to the model
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? "",
          image: data['image'] ?? "",
          isFeatured: data['isFeatured'] ?? false,
          parentId: data['parentId'] ?? "");
    } else {
      return CategoryModel.empty();
    }
  }
}
