import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key,  this.itemCount = 6});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) {
          return Column(
            children: [
              TShimmerEffect(width: 55, height: 55, radius: 55,),
              SizedBox(height: TSizes.spaceBtwItems/2,),
            ],
          );
          },
          separatorBuilder: (_, __) => SizedBox(width: TSizes.spaceBtwItems,),
          itemCount: itemCount ),
    );
  }
}
