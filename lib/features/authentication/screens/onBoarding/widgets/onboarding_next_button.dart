import 'package:e_commerce/features/authentication/controllers/onBoarding/onBoarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_function.dart';


class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => onBoardingController.instance.nextPage(),
        child: Icon(Iconsax.arrow_right),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            // backgroundColor: Colors.white,
            backgroundColor: dark ? TColors.primaryColor : TColors.primaryColor
    ),
      ),
    );
  }
}