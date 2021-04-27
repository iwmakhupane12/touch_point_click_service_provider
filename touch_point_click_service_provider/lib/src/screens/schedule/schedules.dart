import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule/scheduleSettings.dart';

import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

class Schedules extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Schedules(this.onlineOfflineAppBar);
  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final bool schedulesAvailable = true;

  @override
  Widget build(BuildContext context) {
    return BaseWidget.clipedBase(
      Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: ListView(
          children: [
            schedulesAvailable
                ? setDateTime("09 Mar 2021", "15 Mar 2021", "08:00", "16:00")
                : viewText(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: AppIconsUsed.scheduleAddIcon,
            onPressed: () => changeScreen(false)),
      ),
    );
  }

  UserSchedule userSchedule = UserSchedule();

  @override
  void initState() {
    super.initState();
    dummyData();
  }

  void dummyData() {
    userSchedule.docID = "1";
    userSchedule.startDate = "09 Mar 2021";
    userSchedule.endDate = "15 Mar 2021";
    userSchedule.startTime = "08:00";
    userSchedule.endTime = "16:00";
    userSchedule.autoAccept = true;
    userSchedule.autoOnline = false;
  }

  void changeScreen(bool edit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => !edit
            ? ScheduleSettings(onlineOfflineAppBar: widget.onlineOfflineAppBar)
            : ScheduleSettings(
                onlineOfflineAppBar: widget.onlineOfflineAppBar,
                userSchedule: userSchedule,
              ),
      ),
    );
  }

  Widget returnSchedule() {
    //Use setDateTime with list builder
  }

  Widget setDateTime(String date1, String date2, String time1, String time2) {
    return UtilWidget.baseCard(
      156,
      Column(
        children: [
          schedulesWidgets(date1, date2, time1, time2),
        ],
      ),
    );
  }

  Widget schedulesWidgets(
      String date1, String date2, String time1, String time2) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          ListTile(
            leading: AppIconsUsed.calendarIcon,
            title: Text('$date1 - $date2',
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
          ListTile(
            leading: AppIconsUsed.scheduleTime,
            title: Text('$time1 - $time2',
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              deleteEditBtns(),
            ],
          ),
        ],
      ),
    );
  }

  Widget deleteEditBtns() {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 4.0),
        child: CircleAvatar(
          backgroundColor: AppColors.appBackgroundColor,
          radius: 20,
          child: IconButton(
              icon: AppIconsUsed.editIcon,
              onPressed: () {
                changeScreen(true);
              }),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 4.0),
        child: CircleAvatar(
          backgroundColor: AppColors.appBackgroundColor,
          radius: 20,
          child: IconButton(
              icon: AppIconsUsed.deleteIcon,
              onPressed: () {
                //changeScreen();
              }),
        ),
      ),
    ]);
  }

  Widget viewText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: "There are no set schedules.\n\n"),
                TextSpan(
                    text: "Click here ",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        changeScreen(false);
                      }),
                TextSpan(
                    text: "to set a schedule OR the round button below.\n\n"),
                TextSpan(
                    text:
                        'If a schedule is set, the system can automatically set you "Online" and also accept requests when set to do so',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
