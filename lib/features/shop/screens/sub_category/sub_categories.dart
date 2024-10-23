import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/images/rounded_home_page_image.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/category_controller.dart';
import 'package:e_commerce/features/shop/model/category_model.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widget/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    print('@@@@@@@@@@@@@ Category in subcat screen $category');
    return Scaffold(
      appBar: TAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedImage(
                imageUrl: category.image,
                // imageUrl: TImages.nike_blue_shoes,
                width: double.infinity,
                applyImageRadius: true,
                isNetworkImage: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSection,
              ),

              /// Sub-categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);

                    /// Return appropriate widget based on snapshot state
                    if (widget != null) return widget;

                    final subCategories = snapshot.data;

                    print('++++++++++++  Sub Category $subCategories');

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories?[index];

                          print('-----------Sub Category $subCategory');

                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory!.id),
                              builder: (context, snapshot) {
                                // const loader = TVerticalProductShimmer();
                                // final widget =
                                //     TCloudHelperFunctions.checkMultiRecordState(
                                //         snapshot: snapshot, loader: loader);
                                //
                                // /// Return appropriate widget based on snapshot state
                                // if (widget != null) return widget;

                                final products = snapshot.data;
                                if (products == null) {
                                  return TShimmerEffect(
                                      width: 180, height: 180);
                                }

                                return Column(
                                  children: [
                                    /// Heading
                                    SectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(
                                        () => AllProducts(
                                          title: subCategory.name,
                                          futureMethod:
                                              controller.getCategoryProducts(
                                                  categoryId: subCategory.id,
                                                  limit: 2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwSection / 2,
                                    ),

                                    SizedBox(
                                      height: 200,
                                      child: ListView.separated(
                                          padding: EdgeInsets.all(
                                              TSizes.defaultSpace),
                                          itemCount: products.length,
                                          // shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                width: TSizes.spaceBtwSection,
                                              ),
                                          itemBuilder: (context, index) =>
                                              HorizontalProductCard(
                                                product: products[index],
                                              )),
                                    ),
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
