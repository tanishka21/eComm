import 'package:e_commerce/common/brands/brand_card.dart';
import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/products/sortable/sortable_products.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Nike"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Details
              BrandCard(showBorder: true),
              SizedBox(
                height: TSizes.spaceBtwSection,
              ),

              SortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
