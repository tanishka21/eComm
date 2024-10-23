import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/model/product_attribute_model.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel(
      {required this.id,
      required this.image,
      required this.name,
      this.isFeatured,
      this.productsCount});

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'productsCount': productsCount,
      'isFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    print('================>>>>>>>>>>Brand Model');
    print('==========>>>>>>>>>>>>>>>Brand Model data $data');
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['id'] ?? '',
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      isFeatured: data['isFeatured'] as bool,
      productsCount: int.parse((data['productsCount'] ?? 0).toString()),
    );
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      if (data.isEmpty) return BrandModel.empty();
      return BrandModel(
        id: document.id,
        image: data['image'] ?? '',
        name: data['name'] ?? '',
        isFeatured: data['isFeatured'] as bool,
        productsCount: int.parse((data['productsCount'] ?? 0).toString()),
      );
    } else {
      return BrandModel.empty();
    }
  }
}
