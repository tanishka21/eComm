import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/custom_shape/container/rounded_conatiner.dart';
import 'package:e_commerce/common/widget/success_screen/success_screen.dart';
import 'package:e_commerce/features/shop/controller/product/cart_controller.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/cart_item.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../controller/product/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TCalculator.calculateTotalPrice(subTotal, 'IN');

    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              CartItems(
                showRemoveButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwSection,
              ),

              /// Add Coupon Code
              CouponCode(),
              SizedBox(
                height: TSizes.spaceBtwSection,
              ),

              /// Billing Section
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Billing amount section - total Pricing
                    BillingAmountSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Divider
                    const Divider(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Payment Methods
                    BillingPaymentSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Address
                    BillingAddressSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : TLoader.warningSnackBar(
                    title: 'Empty Cart',
                    message: 'Add Items in the cart in order to proceed.'),
            child: Text("Checkout \$${totalAmount}")),
      ),
    );
  }
}
