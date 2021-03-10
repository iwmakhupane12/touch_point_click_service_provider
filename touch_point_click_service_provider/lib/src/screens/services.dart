import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

class Services extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Services(this.onlineOfflineAppBar);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
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
    );
  }
}
