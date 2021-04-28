import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/components/dateTimeConvertFunctions.dart';
import 'package:touch_point_click_service_provider/src/components/validateInput.dart';

import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';

import 'package:touch_point_click_service_provider/src/screens/schedule/setSchedule.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/services/scheduleDatabase.dart';

class ScheduleSettings extends StatefulWidget {
  final UserSchedule userSchedule;
  final bool newSchedule;

  ScheduleSettings({this.userSchedule, this.newSchedule});

  @override
  _ScheduleSettingsState createState() => _ScheduleSettingsState();
}

class _ScheduleSettingsState extends State<ScheduleSettings> {
  String _uid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  UserSchedule userSchedule;
  bool newSchedule;
  static const String update = "Update", save = "Save";
  List<Widget> listActions = [];

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser.uid; //Getting user Id
    newSchedule = widget.newSchedule;
    if (widget.userSchedule != null && !newSchedule) {
      userSchedule = widget.userSchedule;
      listActions.add(deleteIconBtn());
    } else {
      if (widget.userSchedule != null) {
        userSchedule = widget.userSchedule;
      } else {
        userSchedule = UserSchedule(autoOnline: false, autoAccept: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      display(),
      null,
      "Schedule Settings",
      saveBottomBtn(),
      null,
      listActions,
    );
  }

  Widget deleteIconBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: AppColors.appBackgroundColor,
        radius: 20,
        child: IconButton(
            icon: AppIconsUsed.deleteIcon,
            onPressed: () {
              deleteBtn();
            }),
      ),
    );
  }

  Widget saveBottomBtn() {
    return InkWell(
      onTap: () {
        !newSchedule ? updateBtn() : saveBtn();
      },
      child: Container(
          color: Colors.blue,
          height: 50,
          child: Align(
              alignment: Alignment.center,
              child: AppTextStyles.normalText(
                  !newSchedule ? update : save, normal, white, 1))),
    );
  }

  Widget display() {
    return ListView(
      children: [
        Column(
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
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: textHolder("Schedule"),
                ),
                scheduleDisplay(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String dateReturn() {
    return userSchedule.startDate != null
        ? "${userSchedule.startDate}${checkEndDate()}"
        : "Set date";
  }

  String checkEndDate() {
    return userSchedule.endDate != null ? " - ${userSchedule.endDate}" : "";
  }

  String timeReturn() {
    if (userSchedule.startTime != null) {
      if (!userSchedule.startTime.contains("/")) {
        return "${userSchedule.startTime} - ${userSchedule.endTime}";
      } else {
        return "${userSchedule.startTime}";
      }
    } else {
      return "Set time";
    }
  }

//Time that has passed, will be continued as an update
  bool timeHasPassed = false;

  bool checkIfTimePassed(String endTime) {
    String timeOfDay = DateTimeConvert.addZeroToTime(
        "${TimeOfDay.now().hour}", "${TimeOfDay.now().minute}");
    int intTimeOfDay = int.parse(timeOfDay.replaceAll(":", ""));
    int intEndTime = int.parse(endTime.replaceAll(":", ""));
    if (intTimeOfDay >= intEndTime) {
      timeHasPassed = true;
    }
    return timeHasPassed;
  }

  double sizeCard() {
    if (startDateBln && startTimeBln) {
      return 200;
    } else if (startDateBln || startTimeBln) {
      return 180;
    } else {
      return 160;
    }
  }

  Widget scheduleDisplay() {
    return UtilWidget.baseCard(
      sizeCard(),
      Column(
        children: [
          ListTile(
            leading: AppIconsUsed.calendarIcon,
            title: Text(dateReturn(),
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
          startDateBln
              ? ValidateInput.errorText("Date" + ValidateInput.errorTextNull)
              : Container(),
          ListTile(
            leading: AppIconsUsed.scheduleTime,
            title: Text(timeReturn(),
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
          startTimeBln
              ? ValidateInput.errorText("Time" + ValidateInput.errorTextNull)
              : Container(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => addDateTimeRangeScreen(true),
                  style: UtilWidget.textButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      userSchedule.startDate != null ? "Edit Date" : "Set Date",
                      style: AppTextStyles.normalBlack(normal, Colors.blue),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => // openBottomSheet(false),
                      addDateTimeRangeScreen(false), // timeRangePicker(),
                  style: UtilWidget.textButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      userSchedule.startTime != null ? "Edit Time" : "Set Time",
                      style: AppTextStyles.normalBlack(normal, Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addDateTimeRangeScreen(bool isDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SetSchedule(userSchedule, isDate, newSchedule);
        },
      ),
    ).then((value) {
      userSchedule = value;
      setState(() {});
    });
  }

  Widget textHolder(String text) {
    return Text(
      text,
      style: AppTextStyles.normalBlack(normal, black),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
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

  bool absorb = false;

  void setAbsorbState(bool state) {
    setState(() {
      absorb = state;
    });
  }

  bool startDateBln = false,
      endDateBln = false,
      startTimeBln = false,
      endTimeBln = false;

  bool validateSetVars() {
    bool validate = false;

    if (userSchedule != null) {
      userSchedule.startDate == null
          ? startDateBln = true
          : startDateBln = false;

      userSchedule.startTime == null
          ? startTimeBln = true
          : startTimeBln = false;
    }

    if (!startDateBln && !startTimeBln) {
      validate = true;
    } else {
      setState(() {});
    }

    return validate; //validate;
  }

  void saveBtn() async {
    //results = null;
    if (validateSetVars()) {
      UtilWidget.showLoadingDialog(context, "Saving...");
      setAbsorbState(true);
      dynamic result = await ScheduleDatabase(_uid).addSchedule(
          userSchedule.startDate,
          userSchedule.endDate,
          userSchedule.startTime,
          userSchedule.endTime,
          userSchedule.autoOnline,
          userSchedule.autoAccept);
      if (result != null) {
        if (result == "Schedule Added") {
          Navigator.pop(context);
          UtilWidget.showSnackBar(context, "Schedule Saved");
          setAbsorbState(false);
        } else {
          print("Unknown Error");
          Navigator.pop(context);
          setAbsorbState(false);
        }
      }
    } else {
      setAbsorbState(false);
    }
  }

  void deleteBtn() async {
    UtilWidget.showLoadingDialog(context, "Deleting...");
    setAbsorbState(true);
    dynamic result =
        await ScheduleDatabase(_uid).removeSchedule(userSchedule.docID);
    if (result != null) {
      if (result == "Schedule Deleted") {
        UtilWidget.showSnackBar(context, "Schedule Deleted");
        Navigator.pop(context); //Remove loading dialog
        Timer(Duration(milliseconds: 500), () => Navigator.pop(context));
      } else {
        print("Unknown Error");
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      setAbsorbState(false);
    }
  }

  void updateBtn() async {
    if (validateSetVars()) {
      UtilWidget.showLoadingDialog(context, "Updating...");
      setAbsorbState(true);
      dynamic result = await ScheduleDatabase(_uid).updateSchedule(
          userSchedule.docID,
          userSchedule.startDate,
          userSchedule.endDate,
          userSchedule.startTime,
          userSchedule.endTime,
          userSchedule.autoOnline,
          userSchedule.autoAccept);
      if (result != null) {
        if (result == "Schedule Updated") {
          Navigator.pop(context);
          UtilWidget.showSnackBar(context, "Schedule Updated");
          setAbsorbState(false);
        } else {
          print("Unknown Error");
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
        setAbsorbState(false);
      }
    }
  }
}
