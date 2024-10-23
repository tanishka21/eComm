import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/features/shop/controller/banner_controller.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widget/custom_shape/container/circular_container.dart';
import '../../../../../common/widget/images/rounded_home_page_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value)
        return TShimmerEffect(width: double.infinity, height: 190);

      if (controller.banners.isEmpty) {
        return Center(
          child: Text('No Data Found'),
        );
      } else {
        return Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index),
                ),
                items: controller.banners
                    .map((banner) => TRoundedImage(
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                          onPressed: () => Get.toNamed(banner.targetScreen),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
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
    });
  }
}
