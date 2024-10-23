import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_title_text.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/product/variation_controller.dart';
import 'package:e_commerce/features/shop/model/product_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../../common/chips/choice_chips.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)
            RoundedContainer(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                children: [
                  Row(
                    children: [
                      SectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ProductTitleText(
                                title: 'Price',
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),

                              // Sale Price
                              ProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ),

                          /// Stock
                          Row(
                            children: [
                              const ProductTitleText(
                                title: 'Stock',
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),

                      /// Actual Price
                    ],
                  ),

                  /// Variation Description
                  ProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),

          /// Attribute
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                    attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                    product.productVariations!, attribute.name!)
                                .contains(attributeValue);

                            return TChoiceChip(
                                selected: isSelected,
                                text: attributeValue,
                                onSelected: available
                                    ? (selected) {
                                        if (selected && available) {
                                          controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              attributeValue);
                                        }
                                      }
                                    : null);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SectionHeading(
          //       title: 'Size',
          //       showActionButton: false,
          //     ),
          //     const SizedBox(
          //       width: TSizes.spaceBtwItems / 2,
          //     ),
          //     Wrap(
          //       spacing: 8,
          //       children: [
          //         TChoiceChip(
          //           selected: true,
          //           text: 'EU 34',
          //           onSelected: (value) {},
          //         ),
          //         TChoiceChip(
          //             selected: false, text: 'EU 36', onSelected: (value) {}),
          //         TChoiceChip(
          //             selected: false, text: 'EU 38', onSelected: (value) {}),
          //       ],
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
