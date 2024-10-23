import 'package:e_commerce/data/repositories/product/product_repository.dart';
import 'package:e_commerce/features/categories/category_repository.dart';
import 'package:e_commerce/features/shop/model/category_model.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Load category data
  Future<void> fetchCategories() async {
    try {
      /// show loader while loading categories
      isLoading.value = true;

      /// Fetch categories form data source (firebase, api, etc.)
      final categories = await _categoryRepository.getAllCategories();
      print('Categories====>>>>>> $categories');

      /// Update the categories list
      allCategory.assignAll(categories);

      /// Filter featured categories
      featuredCategories.assignAll(allCategory
          .where(
              (category) => category.isFeatured && category.parentId.isNotEmpty)
          // .take(2)
          .toList());
    } catch (e) {
      print('================>>>>>>> ${e.toString()}');

      TLoader.errorSnackBar(
          title: 'Oh Snap!! fail to fetch categories', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Load selected category data

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      print('???????????Category ID $categoryId');
      print('???????????Category ID $subCategories');

      return subCategories;
    } catch (e) {
      print('===>>????????Error in getSubCategories controller $e');
      TLoader.errorSnackBar(title: 'Ohh Snap!!!', message: e.toString());
      return [];
    }
  }

  /// Get category or sub category products.
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    final products = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: limit);

    print('********** $products');

    return products;
  }
}
