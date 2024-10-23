import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/icons/circular_icon_favourite_button.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widget/shimmers/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controller/product/favourite_controller.dart';
import 'package:e_commerce/features/shop/screens/home/home.dart';
import 'package:e_commerce/features/shop/screens/wishlist/animation_loader.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(
              HomeScreen(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  final emptyWidget = TAnimationWidget(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: TImages.success_payment,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () => Get.off(() => NavigationMenu()),
                  );

                  const loader = TVerticalProductShimmer(
                    itemCount: 2,
                  );
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);

                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return GridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => ProductCardVertical(
                      product: products[index],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
