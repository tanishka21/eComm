import 'package:e_commerce/features/personalization/screens/settings/settings.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/store/store.dart';
import 'features/shop/screens/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunction.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationDuration: Duration(milliseconds: 550),

        // elevation: 0,
        // selectedIndex: controller.selectedIndex.value,
        // onDestinationSelected: (index) =>
        //     controller.selectedIndex.value = index,
        backgroundColor: darkMode ? TColors.black : Colors.white,
        color: darkMode
            ? TColors.white.withOpacity(0.1)
            : TColors.black.withOpacity(0.1),
        // destinations: [
        //
        // ],
        items: [
          (Icon(
            Iconsax.home,
          )),
          Icon(Iconsax.shop),
          Icon(Iconsax.heart),
          Icon(Iconsax.user),
        ],
        onTap: (index) {
          controller.selectedIndex.value = index;
        },
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    StoreScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];
}
