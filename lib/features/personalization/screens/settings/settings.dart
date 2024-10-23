import 'package:e_commerce/common/widget/appbar/appbar.dart';
import 'package:e_commerce/common/widget/custom_shape/container/primary_header_container.dart';
import 'package:e_commerce/common/widget/list_tile/listTile.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../common/widget/list_tile/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Headers
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// App Bar
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),

                  /// User Profile Card
                  UserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Account Settings
                  SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingsMenuTitle(
                    title: "My Addresses",
                    subTitle: "Set shopping delivery address",
                    image: Iconsax.safe_home,
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  SettingsMenuTitle(
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    image: Iconsax.shopping_cart,
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  SettingsMenuTitle(
                    title: "My Orders",
                    subTitle: "In-progress and Completed Orders",
                    image: Iconsax.bag_tick,
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  SettingsMenuTitle(
                    title: "Bank Account",
                    subTitle: "Withdraw balance to registered bank account",
                    image: Iconsax.bank,
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupons",
                    image: Iconsax.discount_shape,
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    title: "Notifications",
                    subTitle: "Set any kind of notification message",
                    image: Iconsax.notification,
                    onTap: () {},
                  ),
                  SettingsMenuTitle(
                    title: "Account Privacy",
                    subTitle: "Manage data usage and connected accounts",
                    image: Iconsax.security_card,
                    onTap: () {},
                  ),

                  /// App settings
                  const SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),
                  SectionHeading(
                    title: "App Settings",
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingsMenuTitle(
                      title: "Load Data",
                      subTitle: "Upload Data to your Cloud Firebase",
                      image: Iconsax.document_upload),
                  SettingsMenuTitle(
                    title: "Geolocation",
                    subTitle: "Set recommendation based on location",
                    image: Iconsax.location,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  SettingsMenuTitle(
                    title: "Safe Mode",
                    subTitle: "Search result is safe for all ages",
                    image: Iconsax.security_user,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  SettingsMenuTitle(
                    title: "HD Image Quality",
                    subTitle: "Set image quality to be seen",
                    image: Iconsax.image,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 350,
              height: 60,
              child: OutlinedButton(
                onPressed: () => Get.to(
                  () => LoginScreen(),
                ),
                child: Text('Logout'),
              ),
            ),
            SizedBox(
              height: TSizes.defaultSpace,
            ),
          ],
        ),
      ),
    );
  }
}
