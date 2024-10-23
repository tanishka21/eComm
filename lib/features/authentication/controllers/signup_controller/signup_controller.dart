import 'package:e_commerce/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/user_model/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variable
  final hiddenPassword = true.obs;
  final privacyPolicy = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Form key for form validation

  /// Sign up
  void signup() async {
    try {
      /// Start Loading
      FullScreenLoader.openLoadingDialog(
          "We are processing your information...", TImages.onBoardingPage1);

      /// Check internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      /// Form Validation

      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Privacy Policy Check

      if (!privacyPolicy.value) {
        // FullScreenLoader.stopLoading();
        TLoader.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      /// Register user in the Firebase Authentication & Save user data in the Firebase

      final userCredential = await AuthenticationRepository.instance
          .registerUserWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      print('User Credentials ============>>>>>>>>>>> ${userCredential}');

      /// Save Authenticated user data in the Firebase
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      print('User details =================>>>>>>>>>>>>>> ${newUser}');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading(); // Stop loader after success

      /// Show Success Message

      TLoader.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      /// Move to Verify EMail Screen
      Get.to(() => VerificationEmailScreen());
    } catch (e) {
      /// Show some Generic Error to the user
      // TLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
      FullScreenLoader.stopLoading();
      TLoader.errorSnackBar(title: 'Error', message: e.toString());
    }

    // } finally {
    //   /// Remove Loader
    //   FullScreenLoader.stopLoading();
    // }
  }
}
