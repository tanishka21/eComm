import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/model/product_attribute_model.dart';
import 'package:e_commerce/features/shop/model/product_variation_model.dart';
import 'package:e_commerce/features/shop/screens/home/duumy_data/dummy_data.dart';

import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        price: 0,
        thumbnail: '',
        productType: '',
        // categoryId: '',
        description: '',
        // productAttribute: '',
        // productVariations: [],
      );

  toJson() {
    return {
      'sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'brand': brand!.toJson(),
      'description': description,
      'productType': productType,
      'productAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'productVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Map json oriented document snapshot from firebase to model

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    print('============>>>>>>>>>>>>>>>data ${data}');
    // print('Title: ${data['title']}');
    print('brand: ${document.id}');
    return ProductModel(
        id: document.id,
        title: data['title'] ?? '',
        sku: data['sku'] ?? '',
        stock: data['stock'] ?? 0,
        isFeatured: data['isFeatured'] ?? false,
        price: double.parse((data['price'] ?? 0.0).toString()),
        salePrice: double.parse((data['price'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        brand: BrandModel.fromJson(data['brand']),
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        productAttributes: (data['productAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList(),
        productVariations: (data['productVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        productType: data['productType'] ?? '');
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
        id: document.id,
        sku: data['sku'] ?? '',
        title: data['title'] ?? '',
        stock: (data['stock'] ?? 0),
        isFeatured: data['isFeatured'] ?? false,
        price: double.parse((data['price'] ?? 0.0).toString()),
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        productType: data['productType'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        brand: BrandModel.fromJson(data['brand']),
        images: data['image'] != null ? List<String>.from(data['image']) : [],
        productAttributes: (data['productAttribute'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList(),
        productVariations: (data['productVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList());
  }
}
