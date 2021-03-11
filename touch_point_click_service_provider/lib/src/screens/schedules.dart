import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/screens/setSchedule.dart';

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
    return Scaffold(
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
          onPressed: () => changeScreen()),
    );
  }

  void changeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SetSchedule(widget.onlineOfflineAppBar),
      ),
    );
  }

  Widget returnSchedule() {
    //Use setDateTime with list builder
  }

  Widget setDateTime(String date1, String date2, String time1, String time2) {
    return Container(
      height: 156,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26, //Color(0x802196F3),
            )
          ],
          borderRadius: BorderRadius.circular(25)),
      child: Column(
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
                //changeScreen();
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
                        changeScreen();
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
