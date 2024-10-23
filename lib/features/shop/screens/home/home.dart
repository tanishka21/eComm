import 'package:e_commerce/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_category.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widget/custom_shape/container/primary_header_container.dart';
import '../../../../common/widget/custom_shape/container/search_container.dart';
import '../../../../common/widget/layouts/grid_layout.dart';
import '../../../../common/widget/text/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Text(
            //   'ok',
            // ),
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// APPBAR
                  HomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),

                  /// CUSTOM SEARCH BAR
                  SearchContainer(
                    text: 'Search in Store',
                    showBorder: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// Category
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Section heading
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        /// Category
                        const HomeCategory(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Body tutorial
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  PromoSlider(
                    banner: [
                      TImages.bodyBanner1,
                      TImages.bodyBanner2,
                      TImages.bodyBanner3
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),

                  /// Headings
                  SectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    height: 600,
                    child: GridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) => const ProductCardVertical(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSection,
            ),
          ],
        ),
      ),
    );
  }
}
