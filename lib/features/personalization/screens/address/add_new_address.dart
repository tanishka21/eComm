import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/features/personalization/controller/address_controller.dart';
import 'package:e_commerce/features/personalization/screens/address/address.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: GestureDetector(
            onTap: () => Get.to(UserAddressScreen()),
            child: Form(
                key: controller.newAddressKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.name,
                      validator: (value) =>
                          TValidator.validateEmptyText('Name', value),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.phoneNumber,
                      validator: (value) =>
                          TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: 'Phone Number'),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: controller.street,
                            validator: (value) =>
                                TValidator.validateEmptyText('Street', value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: 'Street'),
                          ),
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: controller.postalCode,
                            validator: (value) => TValidator.validateEmptyText(
                                'Postal Code', value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: 'Postal Code'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: controller.city,
                            validator: (value) =>
                                TValidator.validateEmptyText('City', value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: 'City'),
                          ),
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: controller.state,
                            validator: (value) =>
                                TValidator.validateEmptyText('State', value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: 'State'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: controller.country,
                      validator: (value) =>
                          TValidator.validateEmptyText('Country', value),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.global),
                          labelText: 'Country'),
                    ),
                    const SizedBox(
                      height: TSizes.defaultSpace,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.addNewAddress(),
                          child: Text('Save')),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
