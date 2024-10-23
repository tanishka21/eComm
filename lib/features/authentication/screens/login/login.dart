import 'package:e_commerce/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/login_headers.dart';
import 'package:e_commerce/utils/constants/text_string.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widget/login_signup/form_divider.dart';
import '../../../../../common/widget/login_signup/social_buttons.dart';
import '../../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: TSizes.appBarHeight,
              left: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace,
              right: TSizes.defaultSpace),
          child: Column(
            children: [
              ///Logo, title, sub-title
              TLoginHeader(dark: dark),
              ///Form
              TLoginForm(),
              ///Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!,),
              SizedBox(width: TSizes.spaceBtwSection),
              ///Footer
              TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
