import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/images/rounded_home_page_image.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/products/product_cards/product_card_horizontal.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Sports'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              HomePageRoundedBodyImage(
                imageUrl: TImages.bodyBanner1,
                width: double.infinity,
                applyImageRadius: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSection,
              ),

              /// Sub-categories
              Column(
                children: [
                  /// Heading
                  SectionHeading(
                    title: "Sports Shoes",
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSection / 2,
                  ),

                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      padding: EdgeInsets.all(TSizes.defaultSpace),
                        itemCount: 6,
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(
                              width: TSizes.spaceBtwSection,
                            ),
                        itemBuilder: (context, index) =>
                            const HorizontalProductCard()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
