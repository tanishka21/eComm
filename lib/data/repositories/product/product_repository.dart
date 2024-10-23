import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/services/firebase_storage_services.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .limit(2)
          .get();
      print('===============>>>>>>>>>>>>$snapshot');
      final list =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      print('============>>>>>>>>>>>List $list');
      return list;
    } catch (e) {
      print('Error to get data in  product repo');
      throw 'Error in prod repo>>>>>>>>>>:$e';
    }
  }

  ///Get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          // .limit(2)
          .get();
      print('============?????????===>>>>>>>>>>>>$snapshot');
      final list =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      print('============>>>>>>>>?????????>>>List $list');
      return list;
    } catch (e) {
      print('Error to get data in  product repo');
      throw 'Error in prod repo========= :$e';
    }
  }

  /// Fetch products by query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } catch (e) {
      print('Error to get data in  product repo for query ');
      throw 'Error in prod repo :$e';
    }
  }

  /// Fetch products by query
  Future<List<ProductModel>> getFavoriteProducts(List<String> productId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productId)
          .get();
      print('working in product repo');
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } catch (e) {
      print(
          'Error to get data in getFavoriteProducts function in product repo for query ');
      throw 'Error in prod repo :$e';
    }
  }

  ///upload dummy data to the cloud firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(TFirebaseStorageService());

      ///Loop through each product
      for (var product in products) {
        /// Get image data link from local assets
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);
        final url = await storage.uploadImageData(
            'Products/Image', thumbnail, product.thumbnail.toString());

        /// Assign URL to product.thumbnail attributes
        product.thumbnail = url;

        /// Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            final assetImage = await storage.getImageDataFromAssets(image);
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            /// Assign URL to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        ///Upload variation images
        if (product.productType == 'ProductType.variable') {
          for (var variation in product.productVariations!) {
            /// Get image data link form local assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            /// Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            variation.image = url;
          }
        }
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } catch (e) {
      throw 'Error in product repos: $e';
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('brand.id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('brand.id', isEqualTo: brandId)
              .limit(limit)
              .get();
      print(
          '==========>>>>>>>>>>>>>>querysnapshot of getProductsForBrand in prod repo==>>>$querySnapshot ');

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      print(
          '==========>>>>>>>>>>>>>>products of getProductsForBrand in prod repo==>>>$products ');
      return products;
    } catch (e) {
      print('=================Error in product repo $e');
      throw 'Something went wrong, Please try again later';
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 2}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      print(
          ']]]]]]]]]]]]]]]]] productCategoryQuery in product repo $productCategoryQuery ');

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();
      print(
          ']]]]]]]]]]]]]]]]] productCategoryQuery in product repo $productIds ');

      final productQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      print(
          ']]]]]]]]]]]]]]]]] productCategoryQuery in product repo $productQuery ');

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      print(
          ']]]]]]]]]++++ productCategoryQuery in product repo $products ');

      return products;
    } catch (e) {
      print('========?>???????????Error in product repo $e');
      throw 'Something went wrong, Please try again later';
    }
  }
}
