import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:e_commerce/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:flutter/material.dart';

import '../../../../common/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Rating and Reviews are verified and are from people who use the same type of device that you use.'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Overall product Ratings
              const OverallProductRating(),
              RatingIndicator(
                rating: 2.5,
              ),
              Text(
                '12,611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSection,),

              /// User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),

              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
