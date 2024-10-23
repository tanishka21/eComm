import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/common/widget/images/rounded_home_page_image.dart';
import 'package:e_commerce/features/shop/controller/product/checkout_controller.dart';
import 'package:e_commerce/features/shop/model/payment_method_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
        contentPadding: EdgeInsets.all(0),
        onTap: () {
          controller.selectedPaymentMethod.value = paymentMethod;
          Get.back();
        },
        leading: RoundedContainer(
          width: 60,
          height: 40,
          backgroundColor: THelperFunction.isDarkMode(context)
              ? TColors.light
              : TColors.white,
          padding: EdgeInsets.all(TSizes.sm),
          child: Image(
            image: AssetImage(paymentMethod.image),
            fit: BoxFit.contain,
          ),
        ),
        title: Text(paymentMethod.name),
        trailing: Icon(
          Iconsax.arrow_right_34,
        ));
  }
}
