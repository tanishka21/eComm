import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          margin: EdgeInsets.only(top: 10),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: Image.asset(
              TImages.google,
              width: TSizes.iconMd,
              height: TSizes.iconMd,
            ),
          ),
        ),
        SizedBox(width: TSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          margin: EdgeInsets.only(top: 10),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset(
              TImages.facebook,
              width: TSizes.iconMd,
              height: TSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
