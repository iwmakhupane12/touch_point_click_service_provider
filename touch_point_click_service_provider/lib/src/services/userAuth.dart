import 'package:touch_point_click_service_provider/src/models/serviceProvider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:touch_point_click_service_provider/src/services/database.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in with phone & password
  Future signInEmailPassword(String uEmail, String uPassword) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: uEmail, password: uPassword);

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return e.code;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return e.code;
      }
    }
  }

  Future signUpEmailPassword(String email, String password, String name,
      String phone, String altPhone, String regDate) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password); //Signing up

      Database dcCreateUser = Database(userCredential.user.uid);
      dynamic result =
          dcCreateUser.createUser(name, phone, altPhone, email, regDate);
      if (result != null) {
        return "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      return e.code;
    } catch (e) {
      print(e);
    }
  }
}
