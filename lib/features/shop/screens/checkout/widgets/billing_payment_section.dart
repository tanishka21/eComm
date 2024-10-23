import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce/features/shop/model/payment_method_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/product/checkout_controller.dart';
import 'package:get/get.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    final dark = THelperFunction.isDarkMode(context);
    return Column(
      children: [
        SectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Obx(
          () => SingleChildScrollView(
            child: Row(
              children: [
                RoundedContainer(
                  width: 30,
                  height: 35,
                  backgroundColor: dark ? TColors.light : TColors.white,
                  padding: EdgeInsets.all(TSizes.sm),
                  child: Image(
                    image:
                        AssetImage(controller.selectedPaymentMethod.value.image),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems * 4,
                ),
                // RoundedContainer(
                //   width: 60,
                //   height: 35,
                //   backgroundColor: dark ? TColors.light : TColors.white,
                //   padding: EdgeInsets.all(TSizes.sm),
                //   child: Image(
                //     image: AssetImage(TImages.google_pay),
                //     fit: BoxFit.contain,
                //   ),
                // ),
                // const SizedBox(
                //   height: TSizes.spaceBtwItems,
                // ),
                // Text(
                //   'Google pay',
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
