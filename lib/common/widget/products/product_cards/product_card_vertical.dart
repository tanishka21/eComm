import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/common/widget/images/rounded_home_page_image.dart';
import 'package:e_commerce/common/widget/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce/features/shop/controller/product/product_controller.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_details.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/screens/product_details/widgets/product__add_to_cart_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../style/shadow.dart';
import '../../text/brand_title_text_with_verified_icon.dart';
import '../../text/product_price_text.dart';
import '../../text/product_title_text.dart';
import 'package:get/get.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunction.isDarkMode(context);

    /// Container with side paddings, color, edges, radius and shadow
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailsScreen(
          product: product,
        ),
      ),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.black : TColors.grey,
        ),
        child: Column(
          children: [
            /// Thumbnail, wishlist button, discount tag
            RoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.darkerGrey,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  /// Sale tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: RoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          '${salePercentage}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),

                  /// Favorite icon button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(
                      productId: product.id,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),

            /// Details of product
            // SizedBox(
            //   height: TSizes.defaultSpace,
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 3,
                  ),
                  BrandTitleTextWithVerifiedIcon(
                    title: product.brand!.name,
                  ),
                ],
              ),
              // ),
            ),
            const Spacer(),

            /// Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// price
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.variable.toString() &&
                          product.salePrice > 0)
                        Padding(
                          padding: EdgeInsets.only(left: TSizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(left: TSizes.sm),
                        child: ProductPriceText(
                          price: controller.getProductPrice(product),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Add to cart button (-) (+)
                ProductCardAddToCartButton(
                  product: product,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
