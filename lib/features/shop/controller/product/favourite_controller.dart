import 'dart:convert';

import 'package:e_commerce/data/repositories/product/product_repository.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/local_storage/storage_utility.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  /// Toggle
  void toggleFavoriteProduct(String productId) {
    print('====>>>>>>>Product Id from Favorite controller $productId');
    bool fav = isFavorite(productId);
    if (!fav) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoader.customToast(message: 'Product has been added to the Wishlist.');
    } else if (favorites.containsKey(productId) &&
        favorites[productId] == false) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoader.customToast(message: 'Product has been added to the Wishlist.');
    } else {
      favorites[productId] = false;
      TLocalStorage.instance().removeData(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoader.customToast(
          message: 'Product has been removed from the Wishlist.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorite = json.encode(favorites);
    print('=======>>>>>>>>>>>>Encoded favorites $encodedFavorite');
    TLocalStorage.instance().saveData('favorites', encodedFavorite);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    List<String> favListKey = [];
    favorites.keys.forEach((key) {
      print('${favorites[key]}');
      if(favorites[key] == true){
        favListKey.add(key);
      }
    });
    print('????????????Favlistkey ${favorites.keys}');
    print('????????????Favlistkey $favListKey');
    return await ProductRepository.instance.getFavoriteProducts(favListKey);
  }
}
