import 'package:e_commerce/features/personalization/controller/user_controller.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widget/appbar/appbar.dart';
import '../../../../../common/widget/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_string.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return TShimmerEffect(width: 80, height: 15);
            }
            return Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.grey),
            );
          }),
        ],
      ),
      actions: [
        CartCounterIcon(

          iconColor: TColors.white,
          counterBgColor: TColors.black,
          counterTextColor: TColors.white,
        )
      ],
    );
  }
}
