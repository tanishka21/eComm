import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/cupertino.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key, this.itemCount = 2});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        mainAxisExtent: 80,
        itemCount: itemCount,
        itemBuilder: (_, __) => TShimmerEffect(width: 300, height: 300));
  }
}
