import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widget/shimmers/vertical_product_shimmer.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/category_controller.dart';
import 'package:e_commerce/features/shop/model/category_model.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/category_brands.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              CategoryBrands(category: category),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Products
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    final response =
                        TCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: TVerticalProductShimmer());
                    if (response != null) return response;

                    final products = snapshot.data!;

                    return Column(
                      children: [
                        SectionHeading(
                          title: 'You might like',
                          onPressed: () => Get.to(AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                                categoryId: category.id, limit: -1),
                          )),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        GridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: products[index],
                          ),
                        ),
                      ],
                    );
                  }),
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
