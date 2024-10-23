import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  ///Get all images from product and variation
  List<String> getAllProductImages(ProductModel product) {
    /// Use Set to add unique images only
    Set<String> images = {};

    /// load thumbnail image
    images.add(product.thumbnail);

    /// Assign thumbnail as selected image
    selectedProductImage.value = product.thumbnail;

    ///Get all image from the Product Model if not null
    if (product.images != null) {
      images.addAll(product.images!);
    }

    /// Get all images from the product Variations if not null.
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }
    return images.toList();
  }

  /// Show image pages
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace,
                        vertical: TSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: Text('Close'),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
