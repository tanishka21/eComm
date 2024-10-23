import 'package:e_commerce/common/brands/brand_card.dart';
import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/products/sortable/sortable_products.dart';
import 'package:e_commerce/common/widget/shimmers/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controller/brand_controller.dart';
import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Details
              BrandCard(
                showBorder: true,
                brand: brand,
              ),
              SizedBox(
                height: TSizes.spaceBtwSection,
              ),

              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = TVerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record found
                    final brandProducts = snapshot.data!;
                    return SortableProducts(
                      products: brandProducts,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
