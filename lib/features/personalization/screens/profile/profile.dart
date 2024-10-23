import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/images/circular_image.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/personalization/controller/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import 'widgets/change_name_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Profile"),
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkingImage =
                          controller.user.value.profilePicture;
                      final image = networkingImage.isNotEmpty
                          ? networkingImage
                          : TImages.user_2;
                      return controller.imageUploading.value
                          ? TShimmerEffect(width: 80, height: 80)
                          : CircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkingImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfileImage(),
                      child: const Text("Change Profile Picture"),
                    ),
                  ],
                ),
              ),

              /// Details
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              SectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProfileMenu(
                onPressed: () => Get.to(() => ChangeName()),
                title: "Name",
                value: controller.user.value.fullName,
              ),
              ProfileMenu(
                onPressed: () {},
                title: "UserName",
                value: controller.user.value.username,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Heading personal info

              SectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                onPressed: () {},
                title: "User ID",
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                onPressed: () {},
                title: "E-mail",
                value: controller.user.value.email,
              ),
              ProfileMenu(
                onPressed: () {},
                title: "Phone Number",
                value: controller.user.value.phoneNumber,
              ),
              ProfileMenu(
                onPressed: () {},
                title: "Gender",
                value: 'Female',
              ),
              ProfileMenu(
                onPressed: () {},
                title: "Date of Birth",
                value: '21 Jul, 2000',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWaringPopup(),
                  child: Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
