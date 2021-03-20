import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

import 'package:touch_point_click_service_provider/src/screens/requests/requestReceipt.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/requestInvoice.dart';

class PastRequest extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  PastRequest(this.onlineOfflineAppBar);

  @override
  _PastRequestState createState() => _PastRequestState();
}

class _PastRequestState extends State<PastRequest> {
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
        Container(
          child: Center(child: Text("Tracking")),
        ),
        RequestInvoice(), //RequestReceipt(),
        Container(
          child: Center(
            child: Text("Details"),
          ),
        ),
      ],
    );
  }

  Widget menuButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, color: Colors.black),
      onSelected: (String newValue) => setState(
        () {
          /*
              categorySelected = newValue;
              categoryController.text = categorySelected;*/
        },
      ),
      itemBuilder: (BuildContext context) => this._dropDownMenuItems,
    );
  }

  static const List<String> actions = [
    'Payment Update',
    'Send Client Invoice',
    'Get Invoice'
  ];

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
