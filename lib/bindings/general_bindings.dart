import 'package:e_commerce/features/shop/controller/product/checkout_controller.dart';
import 'package:e_commerce/features/shop/controller/product/variation_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
  }
}
