import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      /// Fetch products
      final products = await productRepository.getFeaturedProducts();

      /// Assign Products
      featureProducts.assignAll(products);

      print('Products===>>> $products');
    } catch (e) {
      print('==========>>>>>>>>>>.Error in product controller $e');
      TLoader.errorSnackBar(title: 'oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      /// Fetch products
      final products = await productRepository.getAllFeaturedProducts();
      print(' ?????????=========>>>>>>.All Products===>>> $products');
      featureProducts.assignAll(products);
      return products;
    } catch (e) {
      print('==========>>>>>>>>>>.Error in product controller $e');
      TLoader.errorSnackBar(title: 'oh Snap', message: e.toString());
      return [];
    }
  }

  /// Get the product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    /// If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      /// Calculate the smallest and largest price among variations
      for (var variation in product.productVariations!) {
        /// Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        /// Update smallest and largest price
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      // If smallest and largest price are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// Calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    print('=>>>>>>>>>>>>>???????? Percentage ${percentage}%');
    return percentage.toStringAsFixed(0);
  }

  /// Check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock ' : 'Out of Stock';
  }
}
