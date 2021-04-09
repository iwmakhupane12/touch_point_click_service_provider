import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;

  Database(this.uid);

  Future createUser(String name, String phone, String altPhone, String email,
      String address, String regDate) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the user's CollectionReference to add a new user
    txtToReturn = firestoreInstance
        .collection("service_providers")
        .doc(uid)
        .set({
          'provider_name': name,
          'provider_phone': phone,
          'provider_alt_phone': altPhone,
          'provider_email': email,
          'provider_address': address,
          'provider_reg_date': regDate,
          'provider_last_seen': '-1',
          'provider_category': '-1',
          'provider_invoice_num': '-1',
          'phone_verfication': false,
          'email_verfication': false,
          'account_verfication': false,
          'blocked_status': false,
          'online_status': false,
          'provider_num_rated': 35,
          'provider_total_rating': 4.0,
          'fk_provider_id': uid,
        })
        .then((value) => txtToReturn = "User Added")
        .catchError((error) => txtToReturn = "Failed to add user: $error");

    return txtToReturn;
  }
}
