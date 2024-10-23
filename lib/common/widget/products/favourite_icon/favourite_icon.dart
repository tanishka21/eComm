import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controller/product/favourite_controller.dart';
import '../../icons/circular_icon_favourite_button.dart';
import 'package:get/get.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(
      () => CircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? Colors.red : null,
        onPressed: () => controller.toggleFavoriteProduct(productId),
        width: 40,
        height: 35,
      ),
    );
  }
}
