import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/invoiceUpdate.dart';

import 'package:touch_point_click_service_provider/src/screens/requests/requestDetails.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/requestReceipt.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/requestInvoice.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/requestTracking.dart';

class PastRequest extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  PastRequest(this.onlineOfflineAppBar);

  @override
  _PastRequestState createState() => _PastRequestState();
}

class _PastRequestState extends State<PastRequest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PopupMenuItem<String>> _dropDownMenuItems;

  @override
  void initState() {
    super.initState();
    initDropDown();
    listActions.add(menuButton());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: BaseWidget.defaultScreen(
        context,
        _scaffoldKey,
        screenBody(),
        AppBarTabs.threeAppBarBottomTabs("Tracking", "Reciept", "Details"),
        "Past Request",
        widget.onlineOfflineAppBar,
        null,
        listActions,
      ),
    );
  }

  List<Widget> listActions = [];

  Widget screenBody() {
    return TabBarView(
      children: [
        RequestTracking(widget.onlineOfflineAppBar),
        RequestInvoice(), //RequestReceipt(),
        RequestDetails(),
      ],
    );
  }

  Widget menuButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, color: Colors.black),
      onSelected: (String value) => setState(
        () {
          /*
              categorySelected = newValue;
              categoryController.text = categorySelected;*/
          changeScreen(value);
        },
      ),
      itemBuilder: (BuildContext context) => this._dropDownMenuItems,
    );
  }

  static const String updatePayment = "Payment Update";
  static const String sendInvoice = 'Send Client Invoice';
  static const String getInvoice = 'Get Invoice';

  static const List<String> actions = [updatePayment, sendInvoice, getInvoice];

  void changeScreen(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        switch (value) {
          case updatePayment:
            {
              return InvoiceUpdate(
                  onlineOfflineAppBar: widget.onlineOfflineAppBar);
            }
            break;
          case sendInvoice:
            {
              print(sendInvoice); //Loading for Sending Invoice
            }
            break;
          case getInvoice:
            {
              print(getInvoice); //Loading for Sending Invoice
            }
            break;
          default:
            {
              print("Non clicked");
            }
            break;
        }
      }),
    );
  }

  void initDropDown() {
    _dropDownMenuItems = actions
        .map(
          (String value) => PopupMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }
}
