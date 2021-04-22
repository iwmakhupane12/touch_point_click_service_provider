import 'package:firebase_auth/firebase_auth.dart';
import 'package:touch_point_click_service_provider/src/services/database.dart';

class ReturnQueries {
  dynamic initServices() async {
    Database database = Database(FirebaseAuth.instance.currentUser.uid);
    dynamic results = database.fetchServices();
    if (results != null) {
      if (database.queryResults != null) {
        if (database.queryResults == "Success") {
          return results;
        }
      } else if (results == "No Services") {
        //To show popup dialog
        return results;
      } else {
        print("Unknown Error");
      }
    }
  }
}
