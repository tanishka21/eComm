import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/controller/address_controller.dart';
import 'package:get/get.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    final dark = THelperFunction.isDarkMode(context);
    return Column(
      children: [
        SectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  'Tanishka Address',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Text(
                      '+91 8630399004',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_history,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems / 2,
                    ),
                    Expanded(
                      child: Text(
                        'Gurgaon Sector 45, Greenwood City',
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ])
            : Text(
                'Select Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
      ],
    );
  }
}
