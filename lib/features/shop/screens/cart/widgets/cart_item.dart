import 'package:e_commerce/features/shop/controller/product/cart_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widget/products/cart/add_remove_button_cart.dart';
import '../../../../../common/widget/products/cart/cart_item.dart';
import '../../../../../common/widget/text/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showRemoveButton = true});

  final bool showRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return ListView.separated(
      shrinkWrap: true,

      separatorBuilder: (_, __) => SizedBox(
        height: TSizes.spaceBtwSection,
      ),
      itemCount: controller.cartItems.length,
      itemBuilder: (_, index) => Obx(() {
        final item = controller.cartItems[index];
        return Column(
          children: [
            CartItem(
              cartItem: item,
            ),
            if (showRemoveButton)
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            if (showRemoveButton)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),

                      /// Add remove buttons
                      ProductQuantityWithAddRemoveButton(
                        quantity: item.quantity,
                        add: () => controller.addOneItemToCart(item),
                        remove: () => controller.removeOneItemFromCart(item),
                      ),
                    ],
                  ),
                  ProductPriceText(
                      price: (item.price! * item.quantity).toStringAsFixed(1)),
                ],
              ),
          ],
        );
      }),
    );
  }
}
