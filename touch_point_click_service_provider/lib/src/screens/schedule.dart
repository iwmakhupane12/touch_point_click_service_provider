import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/screens/schedules.dart';
import 'package:touch_point_click_service_provider/src/screens/toDoList.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';

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
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: BaseWidget.defaultScreen(
        context,
        screenBody(),
        AppBarTabs.twoAppBarBottomTabs("To-Do-List", "Schedules"),
        "Schedule",
        widget.onlineOfflineAppBar,
      ),
    );
  }

  Widget screenBody() {
    return TabBarView(children: [
      Container(
        color: white,
        child: ToDoList(),
      ),
      Container(
        child: Center(
          child: Schedules(widget.onlineOfflineAppBar),
        ),
      )
    ]);
  }
}
