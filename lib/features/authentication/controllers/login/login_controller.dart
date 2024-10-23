import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'full_screen_loader.dart';

class LoginController extends GetxController {
  /// Variables
  final localStorage = GetStorage();
  final rememberMe = false.obs;
  final hiddenPassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  ///-- Email and Password SignIn

  // Future<void> emailAndPasswordSignIn() async {
  //   try {
  //     FullScreenLoader.openLoadingDialog('Loading you in...');
  //
  //     /// Check INternet Connectivity
  //     final isConnected await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }
  //
  //     /// Form validation
  //     if (!loginFormKey.currentState!.validate()) {
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }
  //   }
  // }
}
