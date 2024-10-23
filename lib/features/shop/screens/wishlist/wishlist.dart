import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/icons/circular_icon_favourite_button.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              GridLayout(
                itemCount: 6,
                itemBuilder: (_, index) => ProductCardVertical(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
