import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/dateTimeConvertFunctions.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

import 'package:touch_point_click_service_provider/src/models/userInvoice.dart';

class InvoiceUpdate extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final UserInvoice invoice;
  InvoiceUpdate({@required this.onlineOfflineAppBar, this.invoice});

  @override
  _InvoiceUpdateState createState() => _InvoiceUpdateState();
}

class _InvoiceUpdateState extends State<InvoiceUpdate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FontWeight normal = FontWeight.normal;

  final Color black = Colors.black;
  final Color white = Colors.white;

  TextEditingController _paidController;

  @override
  void initState() {
    super.initState();
    _paidController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _paidController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      screenBody(),
      null,
      "Client Invoice",
      widget.onlineOfflineAppBar,
      null,
      null,
    );
  }

  Widget screenBody() {
    return ListView(
      children: [
        UtilWidget.baseCard(
          50,
          Align(
              alignment: Alignment.center,
              child: Text("Balance Due: R200",
                  style: AppTextStyles.normalBlack(normal, black))),
        ),
        headerText("Due Date:"),
        InkWell(
          onTap: () => dateSingularPicker(),
          child: UtilWidget.baseCard(
            50,
            Align(
                alignment: Alignment.center,
                child: Text(
                  dueDate == "" ? "Set Due Date" : "Update \u00B7 $dueDate",
                  style: AppTextStyles.normalBlack(normal, black),
                  overflow: TextOverflow.ellipsis,
                )),
          ),
        ),
        headerText("Paid in Rands:"),
        textFieldView(_paidController, TextInputType.number, "e.g. 0, 50, 120"),
        headerText("Previous Payments:"),
        previousPayments(),
        btnSendInvoice(),
      ],
    );
  }

  Widget headerText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
      child: Text(
        text,
        style: AppTextStyles.normalBlack(normal, black),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget textFieldView(TextEditingController controller,
      TextInputType keyboardType, String hint) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.center,
          maxLines: null,
          style: TextStyle(fontSize: 20, height: 1.0),
          decoration: UtilWidget.txtInputDecor(hint, null, null),
        ),
      ),
    );
  }

  final DateTime today = DateTime.now();

  void dateSingularPicker() {
    showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(today.year + 5),
    ).then(
      (DateTime value) {
        if (value != null) {
          DateTime _fromDate = DateTime.now();
          _fromDate = value;
          setState(() => dueDate = DateTimeConvert.dateFormated(_fromDate));
        }
      },
    );
  }

  String dueDate = "";

  Widget previousPayTile(String payment, String date) {
    return ListTile(
      title: Text(payment,
          style: AppTextStyles.normalBlack(normal, black),
          overflow: TextOverflow.ellipsis),
      trailing: Text(date,
          style: AppTextStyles.normalBlack(normal, black),
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget previousPayments() {
    return UtilWidget.baseCard(
      null,
      Column(
        children: [
          ListTile(
            title: Text("No payment yet",
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget btnSendInvoice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {},
          style: UtilWidget.buttonStyle,
          child: Text(
            "Send Invoice",
            style: AppTextStyles.normalBlack(normal, white),
          ),
        ),
      ),
    );
  }
}
