import 'package:touch_point_click_service_provider/src/models/userRequest.dart';
import 'package:touch_point_click_service_provider/src/models/userService.dart';

class SetAndReturnModels {
  static UserRequest userRequest(String id, String clientName,
      String clientAddress, String date, String time, String requestID) {
    UserRequest ur = UserRequest();
    ur.setID(id);
    ur.setClientName(clientName);
    ur.setClientAddress(clientAddress);
    ur.setDate(date);
    ur.setTime(time);
    ur.setRequestID(requestID);
    return ur;
  }

  static UserService userService(String id, String category, String serviceDesc,
      String price, String estTime, String chargeType) {
    UserService us = UserService();
    us.setID(id);
    us.setCategory(category);
    us.setServiceDesc(serviceDesc);
    us.setPrice(price);
    us.setEstTime(estTime);
    us.setChargeType(chargeType);
    return us;
  }
}
