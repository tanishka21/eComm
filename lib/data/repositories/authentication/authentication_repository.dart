import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onBoarding/widgets/onBoarding_page.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Storage variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // final _auth = FirebaseAuth.instance;

  /// Called from main.drt on app launch
  @override
  void onReady() {
    /// Remove the native splash screen
    FlutterNativeSplash.remove();

    /// Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to determine the relevant screen and redirect accordingly.
  void screenRedirect() async {
    // final user = _auth.currentUser;
    //
    // if (user != null) {
    //   /// If the user is logged in
    //   if (user.emailVerified) {
    //     /// If the user email is verified, navigate to the main Navigation Menu
    //     Get.offAll(
    //         () => VerificationEmailScreen(email: _auth.currentUser?.email));
    //   } else {
    //     /// Local Storage
    //     Get.offAll(
    //         () => VerificationEmailScreen(email: _auth.currentUser?.email));
    //   }
    // } else {
    if (kDebugMode) {
      print(
          '=========================Get Storage  Auth Repo    ================');
      print(deviceStorage.read('IsFirstTime'));
    }

    /// Local Storage
    deviceStorage.writeIfNull("IsFirstTime", true);

    /// Check if its the first time launching the app
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => LoginScreen())
        : Get.offAll(() => onBoardingScreen());
  }

  /*-------------------------------Email and Password sign-in-----------------*/

  /// [EmailAuthentication] - SignIn



  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      print('Email==========>>> ${email} and Password==========>>>>>> ${password}');
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'This email address is already in use.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        throw 'The password is too weak.';
      } else {
        throw 'An unknown error occurred: ${e.message}';
      }
    } on PlatformException catch (e) {
      throw 'Platform exception: ${e.message}';
    } catch (e) {
      print('Error in Auth_repo ==============>>>>>>>>>>>>>>> ${e.toString()}');
      throw 'Oh Snap!!!';
    }
  }
}
// }
