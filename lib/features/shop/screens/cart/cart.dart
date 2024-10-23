import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/cart_item.dart';
import 'package:e_commerce/features/shop/screens/wishlist/animation_loader.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../controller/product/cart_controller.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final emptyWidget = TAnimationWidget(
          text: 'Whoops! Cart is empty.',
          animation: TImages.cart_item,
          showAction: true,
          actionText: 'Lets fill this',
          onActionPressed: () => Get.off(() => NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: Padding(

                /// Items in cart
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: CartItems()),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? SizedBox()
          : Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(() =>
                      Text("Checkout \$${controller.totalCartPrice.value}")))),
    );
  }
}
