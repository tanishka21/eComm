import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/product/images_controller.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_details_image_slider.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../product_reviews/product_reviews.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: BottomAddToCart(
        product: product,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1- Product Image Slider
            ProductImageSlider(
              product: product,
            ),

            /// 2- Product Details
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// - Rating & Share
                  RatingAndShare(),

                  /// - Price, Title, Stock & Brand
                  ProductMetaData(
                    product: product,
                  ),

                  /// - Attributes
                  if (product.productType != ProductType.variable.toString())
                    ProductAttributes(
                      product: product,
                    ),
                  if (product.productType != ProductType.variable.toString())
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                  ///  - Checkout Button

                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => Get.to(() => CheckoutScreen()),
                          child: Text('Checkout'))),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  ///  - Description

                  SectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  ///  - Reviews
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionHeading(
                          title: 'Reviews(199)',
                          showActionButton: false,
                        ),
                        IconButton(
                            onPressed: () => Get.to(() => ProductReview()),
                            icon: Icon(Iconsax.arrow_right_3)),
                      ]),
                  const SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
