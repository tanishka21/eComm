import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/features/shop/controller/product/order_controller.dart';
import 'package:e_commerce/features/shop/screens/wishlist/animation_loader.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunction.isDarkMode(context);
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        final emptyWidget = TAnimationWidget(
          text: 'Whoops!! No order Yet!',
          animation: TImages.success_payment,
          showAction: true,
          onActionPressed: () => Get.offAll(() => NavigationMenu()),
        );
        final response = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        final orders = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) => SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          itemBuilder: (_, index) {
            final order = orders[index];
            // RoundedContainer()
            return RoundedContainer(
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
                              order.orderStatusText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                      color: TColors.primaryColor,
                                      fontWeightDelta: 1),
                            ),
                            Text(order.formattedOrderDate,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(order.id,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
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

                      /// delivery date
                      Expanded(
                        child: Row(
                          children: [
                            /// 1- Icon
                            Icon(Iconsax.calendar),
                            const SizedBox(
                              width: TSizes.spaceBtwItems / 2,
                            ),

                            /// Status & Date
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shopping Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(order.formattedDeliveryDate,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
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
            );
          },
        );
      },
    );
  }
}
