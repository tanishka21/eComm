import 'package:e_commerce/common/widget/success_screen/success_screen.dart';
import 'package:e_commerce/features/personalization/controller/address_controller.dart';
import 'package:e_commerce/features/shop/controller/product/cart_controller.dart';
import 'package:e_commerce/features/shop/controller/product/checkout_controller.dart';
import 'package:e_commerce/features/shop/screens/home/home.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../model/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = Get.put(CartController());
  final addressController = Get.put(AddressController());
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoader.warningSnackBar(title: 'Oh Snap!!!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.processing,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        orderDate: DateTime.now(),
      );

      await orderRepository.saveOrder(order, userId);
      cartController.clearCart();

      Get.off(() => SuccessScreen(
            image: TImages.success_payment,
            subTitle: 'Your item will be shipped soon!',
            title: 'Payment Success!',
            onPressed: () => Get.offAll(() => HomeScreen()),
          ));
    } catch (e) {
      print('nvdkfnvkjnbkfg ======>>>>>> $e');
    }
  }
}
