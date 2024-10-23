import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TShimmerEffect(
              width: 50,
              height: 50,
              radius: 50,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Column(
              children: [
                TShimmerEffect(width: 100, height: 15),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}
