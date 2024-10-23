import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';



class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// DropdownButton
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: [
            'Name',
            "Higher Price",
            "Lower Price",
            "Newest",
            "Popularity",
            "Brands"
          ]
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
         const SizedBox(
          height: TSizes.spaceBtwSection,
        ),

        /// Products
        GridLayout(
            itemCount: 6,
            itemBuilder: (_, index) => ProductCardVertical()),
      ],
    );
  }
}