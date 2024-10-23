import 'package:e_commerce/data/repositories/product/product_repository.dart';
import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/brands/brand_repository.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = true.obs;
  final RxList<BrandModel> featuredBrand = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrand.assignAll(
          allBrands.where((brands) => brands.isFeatured ?? false).take(4));
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Get Brands for Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      print(
          'Error in Brand controller in getBrandsForCategory =========>>>>>>> $e');
      TLoader.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  /// -- Get brand specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      print('Error in Brand controller =========>>>>>>> $e');
      TLoader.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }
}
