import 'package:e_commerce/common/widget/shimmers/box_shimmer.dart';
import 'package:e_commerce/common/widget/shimmers/list_tile_shimmer.dart';
import 'package:e_commerce/features/shop/controller/brand_controller.dart';
import 'package:e_commerce/features/shop/model/category_model.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../common/brands/brand_show_card.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          var loader = Column(
            children: [
              const TListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              BoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          );

          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final brands = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];
                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandId: brand.id, limit: 1),
                    builder: (context, snapshot) {
                      final widget =
                          TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;
                      final products = snapshot.data!;
                      return BrandShowCase(
                        brand: brand,
                        images: products.map((e) => e.thumbnail).toList(),
                      );
                    });
              });
        });
  }
}
