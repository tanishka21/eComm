import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:e_commerce/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

import 'brand_card.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../widget/custom_shape/container/rounded_conatiner.dart';
import 'package:get/get.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key,
    required this.images,
    required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(
            brand: brand,
          )),
      child: RoundedContainer(
        width: 390,
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(
            bottom: TSizes.spaceBtwItems, top: TSizes.defaultSpace),
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          children: [
            BrandCard(
              showBorder: false,
              brand: brand,
            ),
            Row(
                children: images
                    .map((image) => brandTopProductImageWidget(image, context))
                    .toList()),
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: RoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(right: TSizes.sm),
        backgroundColor: THelperFunction.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.darkerGrey,
        child: CachedNetworkImage(
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const TShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )),
  );
}
