import 'package:e_commerce/features/shop/controller/product/variation_controller.dart';
import 'package:e_commerce/features/shop/model/cart_model.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/local_storage/storage_utility.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  /// Add to cart item
  void addToCart(ProductModel product) {
    // 1- Quantity check
    if (productQuantityInCart.value < 1) {
      TLoader.customToast(message: 'Select Quantity');
    }
    // 2- variation check
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoader.customToast(message: 'Select Variation');
    }
    // 3- Out of stock status check
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.stock < 1) {
      TLoader.warningSnackBar(
          title: 'Oh Snap!!!', message: 'Selected variation is out of stock');
    } else {
      if (product.stock < 1) {
        TLoader.warningSnackBar(
            title: 'Oh Snap!!!', message: 'Selected product is otu of Stock');
        return;
      }
    }

    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    // Check if item already add to the cart
    final index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoader.customToast(message: 'Your item has been added to the Cart.');
  }

  /// already added items count in cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    try {
      if (product.productType == ProductType.single.toString()) {
        productQuantityInCart.value = getCurrentQuantityInCart(product.id);
      } else {
        final variationId = variationController.selectedVariation.value.id;
        if (variationId.isNotEmpty) {
          productQuantityInCart.value =
              getVariationQuantityInCart(product.id, variationId);
        } else {
          productQuantityInCart.value = 0;
        }
      }
    } catch (e) {
      print('========>>>>>>>>> Error to update add product count $e');
    }

  }

  // add one item to teh cart
  void addOneItemToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  // remove one item from the cart
  void removeOneItemFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
        title: 'Remove Product',
        middleText: 'Are you sure to remove this product?',
        onConfirm: () {
          cartItems.removeAt(index);
          updateCart();
          TLoader.customToast(message: 'Product Removed from the cart.');
          Get.back();
        },
        onCancel: () => () => Get.back());
  }

  //This function convert ProductModel to CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      price: price,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotal();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotal() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += ((item.price)! * item.quantity.toDouble());
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItem', cartItemString);
  }

  void loadCartItems() {
    final cartItemStr =
        TLocalStorage.instance().readData<List<dynamic>>('cartItem');
    if (cartItemStr != null) {
      cartItems.assignAll(cartItemStr
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
    }
    updateCartTotal();
  }

  int getCurrentQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: CartItemModel.empty);
    print('>>>>>>>>>>>>>>>>  Found Item in get variation quantity $foundItem');
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
