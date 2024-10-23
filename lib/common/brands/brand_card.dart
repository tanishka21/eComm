import 'package:flutter/material.dart';

import '../widget/custom_shape/container/rounded_conatiner.dart';
import '../widget/images/circular_image.dart';
import '../widget/text/brand_title_text_with_verified_icon.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/enums.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder, this.onTap,
  });

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
                image: TImages.floral_denim_jeans,
                isNetworkingImage: false,
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
                  BrandTitleTextWithVerifiedIcon(title: 'Nike',brandTextSize: TextSizes.large,),
                  Text(
                    '256 products with good one',

                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.darkerGrey),
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
