import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/features/shop/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widget/custom_shape/container/circular_container.dart';
import '../../../../../common/widget/images/rounded_home_page_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key, required this.banner});

  final List<String> banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          CarouselSlider(
            items: banner
                .map((url) => HomePageRoundedBodyImage(imageUrl: url))
                .toList(),
            // items: [
            //   HomePageRoundedBodyImage(
            //     imageUrl: TImages.bodyBanner1,
            //   ),
            //   const HomePageRoundedBodyImage(
            //     imageUrl: TImages.bodyBanner2,
            //   ),
            //   const HomePageRoundedBodyImage(
            //     imageUrl: TImages.bodyBanner3,
            //   ),
            // ],
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < banner.length; i++)
                    TCircularContainer(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carousalCurrentIndex.value == i
                              ? TColors.primaryColor
                              : TColors.grey,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
