import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';

class ScheduleDatabase {
  final String uid;
  String queryResults;

  ScheduleDatabase(this.uid);

  //To add a Schedule
  Future addSchedule(String startDate, String endDate, String startTime,
      String endTime, bool autoOnline, bool autoAccept) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("schedules")
        .add({
          'start_date': startDate,
          'end_date': endDate,
          'start_time': startTime,
          'end_time': endTime,
          'auto_online': autoOnline,
          'auto_accept': autoAccept,
          'service_provider_id': uid,
        })
        .then((value) => txtToReturn = "Schedule Added")
        .catchError((error) => txtToReturn = "Failed to add schedule: $error");

    return txtToReturn;
  }

  //To remove a Schedule
  Future removeSchedule(String docID) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("schedules")
        .doc(docID)
        .delete()
        .then((value) => txtToReturn = "Schedule Deleted")
        .catchError(
            (error) => txtToReturn = "Failed to delete schedule: $error");

    return txtToReturn;
  }

  Future fetchSchedules() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("schedules")
        .where('service_provider_id', isEqualTo: uid)
        .get();

    if (query != null) {
      if (query.docs.length != 0) {
        List<UserSchedule> userScheduleList = [];
        for (int i = 0; i < query.docs.length; i++) {
          QueryDocumentSnapshot tempDoc = query.docs.elementAt(i);
          userScheduleList.add(UserSchedule(
            startDate: tempDoc['start_date'],
            endDate: tempDoc['end_date'],
            startTime: tempDoc['start_time'],
            endTime: tempDoc['end_time'],
            autoOnline: tempDoc['auto_online'],
            autoAccept: tempDoc['auto_accept'],
            docID: tempDoc.id,
          ));
        }
        queryResults = "Success";
        return userScheduleList;
      } else {
        return "No Schedules";
      }
    } else {
      return "Unknown Error";
    }
  }

  Future updateSchedule(String docID, String startDate, String endDate,
      String startTime, String endTime, bool autoOnline, bool autoAccept) {
    dynamic txtToReturn;

    final firestoreInstance = FirebaseFirestore.instance;

    // Call the services CollectionReference to add a service
    txtToReturn = firestoreInstance
        .collection("schedules")
        .doc(docID)
        .update({
          'start_date': startDate,
          'end_date': endDate,
          'start_time': startTime,
          'end_time': endTime,
          'auto_online': autoOnline,
          'auto_accept': autoAccept,
        })
        .then((value) => txtToReturn = "Service Updated")
        .catchError(
            (error) => txtToReturn = "Failed to update service: $error");

    return txtToReturn;
  }
}
