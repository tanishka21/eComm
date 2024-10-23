import 'package:e_commerce/data/repositories/user/user_repository.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onBoarding/widgets/onBoarding_page.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Storage variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get authenticated User data
  User? get authUser => _auth.currentUser;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Called from main.drt on app launch
  @override
  void onReady() {
    /// Remove the native splash screen
    FlutterNativeSplash.remove();

    /// Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to determine the relevant screen and redirect accordingly.
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        /// Initialized user specific storage
        await TLocalStorage.init(user.uid);
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(
          () => VerificationEmailScreen(
            email: _auth.currentUser?.email,
          ),
        );
      }
    } else {
      /// Local Storage
      deviceStorage.writeIfNull("IsFirstTime", true);

      /// Check if its the first time launching the app
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => onBoardingScreen());
    }

    if (kDebugMode) {
      print(
          '=========================Get Storage  Auth Repo    ================');
      print(deviceStorage.read('IsFirstTime'));
    }
  }

  /*-------------------------------Email and Password sign-in-----------------*/

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('===============>>>>>>>>.. Error in login ${e.toString()}');
      throw 'Error while login';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      print(
          'Email==========>>> ${email} and Password==========>>>>>> ${password}');
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

  /// [EmailVerification] - MAIL VERIFICATION

  Future<void> sendEmailVerification() async {
    try {
      print(
          '==========>>>>>>>>>>>>>> started to send email to verify the email address.');
      await _auth.currentUser?.sendEmailVerification();
      print('==========>>>>>>>>>>>>>> send successfully.');
    } catch (e) {
      print('Error in Auth_repo ==============>>>>>>>>>>>>>>> ${e.toString()}');
      throw 'fail to send Email to verify the email address';
    }
  }

  ///[ForgetPassword] - FORGET PASSWORD
  Future<void> sendPasswordRestEmail(String email) async {
    try {
      print(
          '==========>>>>>>>>>>>>>> started to send email to verify the email address.');
      await _auth.sendPasswordResetEmail(email: email);
      print('==========>>>>>>>>>>>>>> send successfully.');
    } catch (e) {
      if (kDebugMode)
        printError(
            info:
                '===>>>>>>Error to send the forget password email: ${e.toString()}');
      return null;
    }
  }

  /// [GoogleSignInAuthentication] - GOOGLE
  ///
  Future<UserCredential?> signInWithGoogle() async {
    try {
      print('==========>>>>>>>>>>>>>> started to login in google.');

      /// Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      /// Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      /// Create a new credentials
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      /// Once signin , return the usercredentials
      print('==========>>>>>>>>>>>>>> send successfully.');
      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      if (kDebugMode)
        printError(info: '===>>>>>>Error in google Sign in: ${e.toString()}');
      return null;
    }
  }

  /// [ReAuthenticateUser] - AUTHENTICATION
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } catch (e) {
      throw 'Fail reauthenticate with credentials';
    }
  }

  /// [Delete user account] - Delete
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } catch (e) {
      throw 'Fail delete user account';
    }
  }

  /// [LogoutUser] - Valid for any authentication

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print(
          '=========================>>>>>>>>>> Error in logout function==========>>>>>');
      throw 'Error in logout function';
    }
  }
}
