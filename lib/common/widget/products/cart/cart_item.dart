import 'package:e_commerce/features/shop/model/cart_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../images/rounded_home_page_image.dart';
import '../../text/brand_title_text_with_verified_icon.dart';
import '../../text/product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunction.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        /// Title, Price and Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandTitleTextWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: ProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),

              /// Attributes
              Text.rich(TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map(
                      (e) => TextSpan(
                        children: [
                          TextSpan(
                              text: '${e.key}',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${e.value}',
                              style: Theme.of(context).textTheme.bodyLarge)
                        ],
                      ),
                    )
                    .toList(),
              ))
            ],
          ),
        )
      ],
    );
  }
}
