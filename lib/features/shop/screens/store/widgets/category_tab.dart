import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../common/brands/brand_show_card.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child:
          Column(
            children: [
              /// Brands
              BrandShowCase(
                images: [
                  TImages.nike_sliders,
                  TImages.floral_denim_jeans,
                  TImages.nike_sliders,
                ],
              ),
              BrandShowCase(
                images: [
                  TImages.nike_sliders,
                  TImages.floral_denim_jeans,
                  TImages.nike_sliders,
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Products
              SectionHeading(
                title: 'You might like',
                onPressed: () {},
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              GridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const ProductCardVertical(),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSection,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
