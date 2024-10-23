import 'package:flutter/material.dart';

import '../../../../../common/widget/products/cart/add_remove_button_cart.dart';
import '../../../../../common/widget/products/cart/cart_item.dart';
import '../../../../../common/widget/text/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showRemoveButton = true});

  final bool showRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(
        height: TSizes.spaceBtwSection,
      ),
      itemCount: 4,
      itemBuilder: (_, index) => Column(
        children: [
          const CartItem(),
          if (showRemoveButton)
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
          if (showRemoveButton)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),

                    /// Add remove buttons
                    const ProductQuantityWithAddRemoveButton(),
                  ],
                ),
                ProductPriceText(price: '256'),
              ],
            ),
        ],
      ),
    );
  }
}
