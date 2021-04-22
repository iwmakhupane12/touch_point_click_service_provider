import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:touch_point_click_service_provider/src/models/userService.dart';

class Database {
  final String uid;
  String queryResults;

  Database(this.uid);

  Future createUser(String name, String phone, String altPhone, String email,
      String regDate) {
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
          'provider_address': "-1",
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

  //To add a service
  Future addServive(String offeredService, String displayCategory, double price,
      String chargeType, int estTime) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("services")
        .add({
          'service_desc': offeredService,
          'service_category': displayCategory,
          'service_price': price,
          'service_charge_type': chargeType,
          'service_est_time': estTime,
          'service_provider_id': uid,
          'service_deleted': false,
        })
        .then((value) => txtToReturn = "Service Added")
        .catchError((error) => txtToReturn = "Failed to add service: $error");

    return txtToReturn;
  }

  //To add a service
  Future removeService(String docID) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("services")
        .doc(docID)
        .update({'service_deleted': true})
        .then((value) => txtToReturn = "Service Deleted")
        .catchError(
            (error) => txtToReturn = "Failed to deleted service: $error");

    return txtToReturn;
  }

  Future fetchServices() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("services")
        .where('service_provider_id', isEqualTo: uid)
        .get();

    if (query != null) {
      if (query.docs.length != 0) {
        List<UserService> userServiceList = [];
        for (int i = 0; i < query.docs.length; i++) {
          QueryDocumentSnapshot tempDoc = query.docs.elementAt(i);
          userServiceList.add(UserService(
            tempDoc['service_category'],
            tempDoc['service_desc'],
            tempDoc['service_price'],
            tempDoc['service_est_time'],
            tempDoc['service_charge_type'],
            tempDoc.id,
            tempDoc['service_deleted'],
          ));
        }
        queryResults = "Success";
        return userServiceList;
      } else {
        return "No Services";
      }
    } else {
      return "Unknown Error";
    }
  }

  Future updateService(String docID, String offeredService,
      String displayCategory, double price, String chargeType, int estTime) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("services")
        .doc(docID)
        .update({
          'service_desc': offeredService,
          'service_category': displayCategory,
          'service_price': price,
          'service_charge_type': chargeType,
          'service_est_time': estTime,
        })
        .then((value) => txtToReturn = "Service Updated")
        .catchError(
            (error) => txtToReturn = "Failed to update service: $error");

    return txtToReturn;
  }

  Future restoreService(String docID) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("services")
        .doc(docID)
        .update({'service_deleted': false})
        .then((value) => txtToReturn = "Service Restored")
        .catchError(
            (error) => txtToReturn = "Failed to restored service: $error");

    return txtToReturn;
  }
}
