import 'package:e_commerce/features/shop/model/brand_model.dart';
import 'package:flutter/material.dart';

import '../widget/custom_shape/container/rounded_conatiner.dart';
import '../widget/images/circular_image.dart';
import '../widget/text/brand_title_text_with_verified_icon.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/enums.dart';
import '../../utils/constants/sizes.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// ---Icon
            Flexible(
              child: CircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                // overlayColor: THelperFunction.isDarkMode(context)
                //     ? TColors.white
                //     : TColors.black,
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),

            /// --- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTitleTextWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: TColors.darkerGrey),
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
