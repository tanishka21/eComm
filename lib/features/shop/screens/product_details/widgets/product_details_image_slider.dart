import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widget/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widget/appbar/appbar.dart';
import '../../../../../common/widget/custom_shape/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widget/images/rounded_home_page_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/product/images_controller.dart';
import 'package:get/get.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: TColors.primaryColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];

                    return TRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      border: Border.all(
                          color: imageSelected
                              ? TColors.primaryColor
                              : Colors.transparent),
                      padding: EdgeInsets.all(TSizes.sm),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            /// App bar
            TAppBar(
              showBackArrow: true,
              actions: [FavouriteIcon(productId: product.id,)],
            )
          ],
        ),
      ),
    );
  }
}
