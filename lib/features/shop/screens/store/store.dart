import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/cart/cart_menu_icon.dart';
import 'package:e_commerce/common/widget/shimmers/brands_simmer.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/common/brands/brand_card.dart';
import 'package:e_commerce/features/shop/controller/brand_controller.dart';
import 'package:e_commerce/features/shop/controller/category_controller.dart';
import 'package:e_commerce/features/shop/screens/brands/all_brands.dart';
import 'package:e_commerce/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/appbar/tabbar.dart';
import '../../../../common/widget/custom_shape/container/search_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CartCounterIcon(
              // onPressed: () {},
              iconColor: THelperFunction.isDarkMode(context)
                  ? TColors.white
                  : TColors.black,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 440,

                /// Space between AppBar and TabBar
                automaticallyImplyLeading: false,
                backgroundColor: THelperFunction.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,

                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Search Bar
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      SearchContainer(
                        padding: EdgeInsets.zero,
                        text: 'Search in Store',
                        showBackground: false,
                        showBorder: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSection,
                      ),

                      /// ---Featured  Brands
                      SectionHeading(
                        title: 'Featured Brand',
                        onPressed: () => Get.to(() => AllBrandsScreen()),
                        showActionButton: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),

                      ///Brands GRID
                      Obx(() {
                        if (brandController.isLoading.value)
                          return const TBrandsShimmer();

                        if (brandController.featuredBrand.isEmpty) {
                          return Center(
                            child: Text(
                              'No Data Found!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return GridLayout(
                          itemCount: brandController.featuredBrand.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = brandController.featuredBrand[index];
                            return BrandCard(
                              showBorder: true,
                              brand: brand,
                              onTap: () => Get.to(() => BrandProducts(
                                    brand: brand,
                                  )),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),

                ///Tabs --
                bottom: Tabbar(
                  tabs: [
                    Tab(
                      child: Text('Sports'),
                    ),
                    Tab(
                      child: Text('Furniture'),
                    ),
                    Tab(
                      child: Text('Electronics'),
                    ),
                    Tab(
                      child: Text('Clothes'),
                    ),
                    Tab(
                      child: Text('Cosmetics'),
                    ),
                    Tab(
                      child: Text('Shoes'),
                    ),
                    Tab(
                      child: Text('Suits'),
                    )
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            // controller: ,
            children: categories
                .map((category) => CategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
