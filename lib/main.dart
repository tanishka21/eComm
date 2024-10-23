 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';


Future<void> main() async {
  /// Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// --- GetX Local Storage
  await GetStorage.init();

  /// --- Await splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///  Initialize firebase and Authentication

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}



/*---------------------------Email & Password sign-in--------------------------*/

///[EmailAuthentication] - LOGIN
// Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
//   try{
//     return await _auth.signInWithEmailAndPassword(email: email, password: password);
//   } on FirebaseAuthException catch(e){
//     throw FirebaseAuthException(e.code).message;
//
//   }
// }
