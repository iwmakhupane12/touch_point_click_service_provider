import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: BaseWidget.defaultScreen(
        context,
        screenBody(),
        AppBarTabs.twoAppBarBottomTabs("To-Do-List", "Set Schedule"),
        "Schedule",
        widget.onlineOfflineAppBar,
      ),
    );
  }

  Widget screenBody() {
    return TabBarView(children: [
      Container(
        child: Center(child: Text("Tab 1")),
      ),
      Container(
        child: Center(child: ElevatedButton(child:Text("Tab 1"), onPressed:()=>dateRangePicker()),),
      )
    ]);
  }

  void dateRangePicker() {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(2021),
      lastDate: DateTime(2021),
    ).then((DateTimeRange value) {
      if (value != null) {
        DateTimeRange _fromRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );
        _fromRange = value;
        final String range =
            '${DateFormat.yMMMd().format(_fromRange.start)} - ${DateFormat.yMMMd().format(_fromRange.end)}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(range),
          ),
        );
      }
    });
  }
}
