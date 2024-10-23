import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widget/shimmers/vertical_product_shimmer.dart';
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
import '../../controller/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
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
                         HomeCategory(),
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
                  PromoSlider(),
                  SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),

                  /// Headings
                  SectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => AllProducts(
                          title: 'Popular Products',
                          futureMethod: controller.fetchAllFeaturedProducts(),
                        )),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Obx(() {
                    if (controller.isLoading.value)
                      return TVerticalProductShimmer();

                    if (controller.featureProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return SizedBox(
                      height: 600,
                      child: Obx(() {
                        return GridLayout(
                          itemCount: controller.featureProducts.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.featureProducts[index],
                          ),
                        );
                      }),
                    );
                  }),
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
