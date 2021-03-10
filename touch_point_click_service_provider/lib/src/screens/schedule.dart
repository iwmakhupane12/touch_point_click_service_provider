import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

class Schedule extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Schedule(this.onlineOfflineAppBar);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final FontWeight normal = FontWeight.normal;
  final Color black = Colors.black;

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
