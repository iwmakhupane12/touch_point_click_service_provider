import 'package:touch_point_click_service_provider/src/models/serviceProvider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:touch_point_click_service_provider/src/services/database.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpEmailPassword(String email, String password, String name,
      String phone, String altPhone, String address, String regDate) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password); //Signing up

      ServiceProvider serviceProvider;
      Database dcCreateUser = Database(userCredential.user.uid);
      dynamic result = dcCreateUser.createUser(
          name, phone, altPhone, email, address, regDate);
      if (result != null) {
        serviceProvider.id = userCredential.user.uid;
        serviceProvider.emailVerified = userCredential.user.emailVerified;
        serviceProvider.docsVerified = false;
        serviceProvider.phoneVerified = false;
        serviceProvider.name = name;
        serviceProvider.address = address;
        serviceProvider.totalRating = 4.0;
        serviceProvider.numRated = 35;
      }
      return serviceProvider;
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
