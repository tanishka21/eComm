import 'package:e_commerce/features/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:e_commerce/features/authentication/screens/signup/widgets/terms_and_conditions.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_string.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.defaultSpace,
              ),
              Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstName,
                            validator: (value) => TValidator.validateEmptyText(
                                'First name', value),
                            expands: false,
                            decoration: InputDecoration(
                              labelText: TTexts.firstName,
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastName,
                            validator: (value) => TValidator.validateEmptyText(
                                'Last name', value),
                            expands: false,
                            decoration: InputDecoration(
                              labelText: TTexts.lastName,
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSection,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),
                    TextFormField(
                      controller: controller.username,
                      validator: (value) =>
                          TValidator.validateEmptyText('Username', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.username,
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => TValidator.validateEmail(value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.email,
                        prefixIcon: Icon(Iconsax.direct),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),
                    TextFormField(
                      controller: controller.phoneNumber,
                      validator: (value) =>
                          TValidator.validatePhoneNumber(value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.phoneNo,
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        validator: (value) =>
                            TValidator.validatePassword(value),
                        obscureText: controller.hiddenPassword.value,
                        expands: false,
                        decoration: InputDecoration(
                          labelText: TTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hiddenPassword.value =
                                !controller.hiddenPassword.value,
                            icon: Icon(controller.hiddenPassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),

                    ///Terms and conditions checkBox
                    TTermsAndConditionCheckbox(),

                    const SizedBox(
                      height: TSizes.spaceBtwSection,
                    ),

                    ///Signup Button

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // onPressed: () {
                        //   if (controller.signupFormKey.currentState!
                        //       .validate()) {
                        //     controller
                        //         .signup(); // Call signup only if the form is valid
                        //   }
                        // },
                        onPressed: () => controller.signup(),
                        child: const Text(TTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
