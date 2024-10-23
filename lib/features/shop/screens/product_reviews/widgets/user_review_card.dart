import 'package:e_commerce/common/products/ratings/rating_indicator.dart';
import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage(TImages.user_2),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                'Tanishka Goel',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ]),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        /// Reviews
        Row(
          children: [
            RatingIndicator(rating: 4),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              '01 Nov, 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        const ReadMoreText(
          'The user interface of the app is quite intuitive.tubud jgbusgf Tanishka Goel  I was able to navigate and make purchases seamlessly, Great job.',
          trimLines: 2,
          trimExpandedText: ' Less',
          trimCollapsedText: ' show more',
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primaryColor),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primaryColor),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        /// Company Review
        RoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Store',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '02 Nov, 2023',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const ReadMoreText(
                  'The user interface of the app is quite intuitive.tubud jgbusgf Tanishka Goel  I was able to navigate and make purchases seamlessly, Great job.',
                  trimLines: 2,
                  trimExpandedText: ' Less',
                  trimCollapsedText: ' show more',
                  trimMode: TrimMode.Line,
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primaryColor),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
      ],
    );
  }
}
