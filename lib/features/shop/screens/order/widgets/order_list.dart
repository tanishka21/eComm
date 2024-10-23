import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) => SizedBox(height: TSizes.spaceBtwItems,),
      itemBuilder: (_, index) => RoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Row -1
            Row(
              children: [
                /// 1- Icon
                Icon(Iconsax.ship),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),

                /// Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: TColors.primaryColor, fontWeightDelta: 1),
                      ),
                      Text('07 Nov, 2023',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),

                /// Icon
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.arrow_right_34,
                      size: TSizes.iconSm,
                    )),
              ],
            ),
            SizedBox(
              height: TSizes.defaultSpace,
            ),

            /// Row -2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// 1- Icon
                      Icon(Iconsax.tag),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),

                      /// Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('[#256f2]',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),

                      /// Icon
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Iconsax.arrow_right_34,
                      //       size: TSizes.iconSm,
                      //     )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      /// 1- Icon
                      Icon(Iconsax.calendar),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),

                      /// Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shopping Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('03 Feb 2025',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),

                      // /// Icon
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Iconsax.arrow_right_34,
                      //       size: TSizes.iconSm,
                      //     )),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
