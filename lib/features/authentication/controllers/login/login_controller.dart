import 'package:e_commerce/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce/features/personalization/controller/user_controller.dart';
import 'package:e_commerce/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  /// Variables
  final localStorage = GetStorage();
  final rememberMe = false.obs;
  final hiddenPassword = true.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  ///-- Email and Password SignIn

  Future<void> emailAndPasswordSignIn() async {
    try {
      // FullScreenLoader.openLoadingDialog('Loading you in...');
      //
      /// Check Internet Connectivity
      // final isConnected await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      /// Form validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      /// Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      /// Login user using Email & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());


      /// Remove loader
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      print(
          '=============>>>>>>>>>>>>>Error in Login ${e.toString()}=======>>>>');
      TLoader.errorSnackBar(
          title: 'Oh Snap!!! Error while login', message: e.toString());
    }
  }

  ///Google signin authentication
  Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in...', TImages.google);

      // /// network checking
      // final isConnected = await NetworkManager.intance.isConnected();
      // if(!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }
      /// Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      /// Save user record
      await userController.saveUserRecord(userCredentials);

      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: "On Snap!!!. Error while Signin with google",
          message: e.toString());
    }
  }
}
