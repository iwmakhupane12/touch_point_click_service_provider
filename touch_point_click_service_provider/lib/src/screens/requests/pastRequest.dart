import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/requestReceipt.dart';

class PastRequest extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  PastRequest(this.onlineOfflineAppBar);

  @override
  _PastRequestState createState() => _PastRequestState();
}

class _PastRequestState extends State<PastRequest> {
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
          null),
    );
  }

  Widget screenBody() {
    return TabBarView(
      children: [
        Container(
          child: Center(child: Text("Tracking")),
        ),
        RequestReceipt(),
        Container(
          child: Center(
            child: Text("Details"),
          ),
        ),
      ],
    );
  }
}
