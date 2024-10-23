import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/shimmers/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shop/controller/product/product_controller.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/products/sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../model/product_model.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.futureMethod});

  final String title;

  // final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod,
              builder: (context, snapshot) {
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);

                /// Return appropriate widget based on snapshot state
                if (widget != null) return widget;

                /// Products found
                final products = snapshot.data;
                // if(products == null) {
                //   TLoader.errorSnackBar(title: 'Oh shit!!!', message: );
                // }
                print('====>>>> Products in all product.dart $products');

                return SortableProducts(
                  products: products!,
                );
              }),
        ),
      ),
    );
  }
}
