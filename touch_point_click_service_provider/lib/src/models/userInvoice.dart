import 'package:touch_point_click_service_provider/src/models/requestClient.dart';
import 'package:touch_point_click_service_provider/src/models/serviceProvider.dart';
import 'package:touch_point_click_service_provider/src/models/userReciept.dart';

class UserInvoice {
  ServiceProvider _serviceProvider;
  RequestClient _requestClient;
  String _invoiceNo, _invoiceDate, _invoiceDueDate;
  UserReciept _userReciept;
  String _paid, _balanceDue;
  List<PreviousPayment> _previousPayments;
}

class PreviousPayment {
  String _amount, _date;
}
