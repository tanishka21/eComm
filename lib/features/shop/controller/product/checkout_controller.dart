import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(image: TImages.paypal, name: 'Paypal');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(
                      title: 'Select Payment Method',
                      showActionButton: true,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: 'Paypal',
                            name:
                                "assets/payment_methods/cc-mastercard-brands-solid.png")),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: 'Credit Card', name: TImages.credit_card)),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: 'Google Pay', name: TImages.google_pay)),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: 'Master Card', name: TImages.mastercard)),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: 'Visa',
                            name:
                                "assets/payment_methods/cc-visa-brands-solid.png")),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                  ],
                ),
              ),
            ));
  }
}
