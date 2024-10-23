import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: TShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(child: TShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
          ],
        )
      ],
    );
  }
}
