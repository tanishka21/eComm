import 'package:e_commerce/features/shop/screens/sub_category/sub_categories.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widget/image_text/vertical_image_text.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("On Tap event ");
        Get.to(() => SubCategoriesScreen());
      },
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return VerticalImageText(
              image: TImages.shoes_image,
              title: 'Shoes',

              // onTap: () {
              //   print("Tapped");
              //   Get.to(() => const SubCategoriesScreen());
              // }
            );
          },
        ),
      ),
    );
  }
}
