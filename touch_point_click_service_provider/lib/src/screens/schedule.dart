import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule/scheduleSettings.dart';

import 'package:touch_point_click_service_provider/src/screens/schedule/schedules.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule/toDoList.dart';
import 'package:touch_point_click_service_provider/src/services/scheduleDatabase.dart';

class Schedule extends StatefulWidget {
  final dynamic results;
  final String success;

  Schedule(this.results, this.success);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final FontWeight normal = FontWeight.normal;
  final Color black = Colors.black;
  final Color white = Colors.white;

  List<UserSchedule> userScheduleList = [];

  bool schedulesAvailable = true;

  dynamic results;
  String success, _uid;

  UserSchedule userSchedule;

  void initSchedules() {
    if (results != null) {
      if (success == "Success") {
        userScheduleList = results;
      } else if (results == "No Schedules") {
        schedulesAvailable = false;
        print("No Schedules");
      } else {
        print("Unknown Error");
      }
    }
  }

  @override
  void initState() {
    _uid = FirebaseAuth.instance.currentUser.uid; //Getting user Id
    results = widget.results;
    success = widget.success;
    initSchedules();

    /*Temoporary line below*/
    userSchedule = UserSchedule();
    userSchedule.autoOnline = true;
    userSchedule.autoAccept = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: BaseWidget.defaultScreenNoCurve(
        context,
        screenBody(),
        AppBarTabs.twoAppBarBottomTabs("Schedule", "To-Do-List"),
        "Schedule",
        null,
        true,
      ),
    );
  }

  Widget screenBody() {
    return TabBarView(children: [
      Container(child: schedulesBody()),
      Container(
        color: white,
        child: ToDoList(),
      ),
    ]);
  }

  Widget schedulesBody() {
    return BaseWidget.clipedBase(
      Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: ListView(
          children: [
            //schedulesAvailable ? setScheduleListView() : viewText(),
            //!schedulesAvailable ? display() : viewText(),
            checkButtons()
          ],
        ),
        floatingActionButton:
            schedulesAvailable ? deleteButton() : addScheduleButton(),
        bottomNavigationBar: saveBottomBtn(),
      ),
    );
  }

  // ignore: missing_return
  Widget checkButtons() {
    if (userScheduleList.length > 0 && schedulesAvailable != true) {
      return display();
    } else if (userScheduleList.length == 0 && schedulesAvailable != false) {
      return viewText();
    } else if (userScheduleList.length == 0 && schedulesAvailable != true) {
      return Text("Return empty schedule to set");
    }
  }

  FloatingActionButton deleteButton() {
    return FloatingActionButton(
        tooltip: "Delete Schedule",
        backgroundColor: Colors.red,
        child: AppIconsUsed.whiteDeleteIcon,
        onPressed: () => changeScreen(0, false));
  }

  FloatingActionButton addScheduleButton() {
    return FloatingActionButton(
        tooltip: "Add Schedule",
        backgroundColor: Colors.blue,
        child: AppIconsUsed.scheduleAddIcon,
        onPressed: () => addScheduleState());
  }

  void addScheduleState() {
    setState(() => schedulesAvailable = true);
  }

  Widget textHolder(String text) {
    return Text(
      text,
      style: AppTextStyles.normalBlack(normal, black),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget saveBottomBtn() {
    return InkWell(
      onTap: () {
        //!newSchedule ? updateBtn() : saveBtn();
      },
      child: Container(
          color: Colors.blue,
          height: 50,
          child: Align(
              alignment: Alignment.center,
              child: AppTextStyles.normalText("Save", normal, white, 1))),
    );
  }

  Widget display() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: textHolder("Automations"),
        ),
        settings(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: textHolder("Schedule"),
            ),
            //scheduleDisplay(),
          ],
        ),
      ],
    );
  }

  Widget settings() {
    return UtilWidget.baseCard(
      200,
      Column(
        children: [
          ListTile(
            title: textHolder("Go Online Automatically"),
            trailing: Switch(
              value: userSchedule.autoOnline,
              onChanged: (bool value) => setState(
                () => userSchedule.autoOnline = value,
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: textHolder("Accept Requests Automatically"),
            trailing: Switch(
              value: userSchedule.autoAccept,
              onChanged: (bool value) => setState(
                () => userSchedule.autoAccept = value,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
              child: Text(
                "NB: The system will automatically set you as online and accept requests according to your schedule.",
                style: AppTextStyles.normalGreyishSmall(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*******Remove this below ********/
  Column setScheduleListView() {
    List<Widget> tempSchedules = [];
    for (int i = 0; i < userScheduleList.length; i++) {
      UserSchedule tempUserSchedule = userScheduleList.elementAt(i);
      tempSchedules.add(setDateTime(
          i,
          tempUserSchedule.docID,
          tempUserSchedule.startDate,
          tempUserSchedule.endDate,
          tempUserSchedule.startTime,
          tempUserSchedule.endTime));
    }

    return Column(children: tempSchedules);
  }

  void changeScreen(int index, bool edit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => !edit
            ? ScheduleSettings(newSchedule: true)
            : ScheduleSettings(
                userSchedule: userScheduleList.elementAt(index),
                newSchedule: false),
      ),
    ).then(_onGoBack);
  }

  Widget setDateTime(int scheduleIndex, String deleteDocID, String date1,
      String date2, String time1, String time2) {
    return UtilWidget.baseCard(
      156,
      Column(
        children: [
          schedulesWidgets(
              scheduleIndex, deleteDocID, date1, date2, time1, time2),
        ],
      ),
    );
  }

  String nullText(String text) {
    if (text != null) {
      return "- $text";
    }
    return "";
  }

  Widget schedulesWidgets(int scheduleListIndex, String deleteDocID,
      String date1, String date2, String time1, String time2) {
    int index = scheduleListIndex;
    String docID = deleteDocID;
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          ListTile(
            leading: AppIconsUsed.calendarIcon,
            title: AppTextStyles.normalText(
                '$date1 ${nullText(date2)}', normal, black, 1),
          ),
          ListTile(
            leading: AppIconsUsed.scheduleTime,
            title: Text('$time1 ${nullText(time2)}',
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              deleteEditBtns(index, docID),
            ],
          ),
        ],
      ),
    );
  }

  Widget deleteEditBtns(int scheduleIndex, String deleteDocID) {
    int index = scheduleIndex;
    String docID = deleteDocID;
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 4.0),
        child: CircleAvatar(
          backgroundColor: AppColors.appBackgroundColor,
          radius: 20,
          child: IconButton(
              icon: AppIconsUsed.editIcon,
              onPressed: () {
                changeScreen(index, true);
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

  FutureOr _onGoBack(dynamic value) async {
    ScheduleDatabase database = ScheduleDatabase(_uid);
    dynamic backResults = await database.fetchSchedules();

    if (backResults != null) {
      if (backResults != "Unknown Error") {
        setState(() {
          results = backResults;
          success = database.queryResults;
          userScheduleList = [];
          initSchedules();
        });
      } else {
        //Show snackbar of an error loading services, check internet connection
      }
    }
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
                TextSpan(text: "There is no set schedule.\n\n"),
                TextSpan(
                    text: "Click here ",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        addScheduleState();
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
