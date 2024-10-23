import 'package:e_commerce/common/widget/shimmers/category_shimmer.dart';
import 'package:e_commerce/features/shop/controller/category_controller.dart';
import 'package:e_commerce/features/shop/controller/product/product_controller.dart';
import 'package:e_commerce/features/shop/screens/sub_category/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widget/image_text/vertical_image_text.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final product = ProductController.instance;

    // return InkWell(
    // onTap: () {
    //   print("On Tap event ");
    //   Get.to(() => SubCategoriesScreen(
    //         category: c,
    //       ));
    // },
    return Obx(() {
      if (categoryController.isLoading.value) return CategoryShimmer();
      if (categoryController.featuredCategories.isEmpty)
        return Center(
          child: Text(
            'No Data Found>>>>',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );

      return SizedBox(
        height: 80,
        child: ListView.builder(
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];

            print('////////////${category.image}');

            return VerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => SubCategoriesScreen(
                    category: category,
                  )),
            );
          },
        ),
      );
    });
    // );
  }
}
