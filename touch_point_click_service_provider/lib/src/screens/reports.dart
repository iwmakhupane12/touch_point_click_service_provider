import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

class Reports extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Reports(this.onlineOfflineAppBar);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
        context,
        Container(
          child: Center(child: Text("Services")),
        ),
        null,
        "Services",
        widget.onlineOfflineAppBar,
        null);
  }
}
