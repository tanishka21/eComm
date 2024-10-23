import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/features/personalization/controller/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  ///init user data when home screen appears
  @override
  void onInit() {
    initializedNames();
    super.onInit();
  }

  Future<void> initializedNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'We are updating your information....', TImages.success_payment);

      if (!updateUserNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Update user first & last name in the firestrore
      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim()
      };
      print('==========>>>>>>>>>>>${name}');
      await userRepository.updateSingleField(name);

      ///Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      FullScreenLoader.stopLoading();
      TLoader.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');
      Get.off(() => ProfileScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Oh Snap!!!, Fail to update your name', message: e.toString());
    }
  }
}
