import 'package:e_commerce/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  TextEditingController email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordRestEMail() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing your request....', TImages.success_payment);

      // /// network checking
      // final isConnected = await NetworkManager.intance.isConnected();
      // if(!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordRestEmail(email.text.trim());

      FullScreenLoader.stopLoading();
      Get.to(
            () =>
            ResetPasswordScreen(
              email: email.text.trim(),
            ),
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Oh Snap!!!, Error to reset the password',
          message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing your request....', TImages.success_payment);

      // /// network checking
      // final isConnected = await NetworkManager.instance.isConnected();
      // if(!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      await AuthenticationRepository.instance
          .sendPasswordRestEmail(email);

      FullScreenLoader.stopLoading();

    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Oh Snap!!!, Error to again reset the password',
          message: e.toString());
    }

}}
