import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/dateTimeConvertFunctions.dart';

import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';

import 'package:touch_point_click_service_provider/src/screens/schedule/setSchedule.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/services/scheduleDatabase.dart';

class ScheduleSettings extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final UserSchedule userSchedule;

  ScheduleSettings({@required this.onlineOfflineAppBar, this.userSchedule});

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
  bool newSchedule = false;
  static const String update = "Update", delete = "Delete", save = "Save";
  List<Widget> listActions = [];

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser.uid; //Getting user Id

    if (widget.userSchedule != null) {
      userSchedule = widget.userSchedule;
      actions = [update, delete];
      initDropDownBtn();
    } else {
      userSchedule = UserSchedule(autoOnline: false, autoAccept: false);
      newSchedule = true;
      actions = [save];
      initDropDownBtn();
    }

    listActions.add(menuButton());
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      display(),
      null,
      "Schedule Settings",
      widget.onlineOfflineAppBar,
      null,
      listActions,
    );
  }

  List<String> actions = [];
  List<PopupMenuItem<String>> _dropDownMenuItems;

  void initDropDownBtn() {
    _dropDownMenuItems = actions
        .map(
          (String value) => PopupMenuItem<String>(
            value: value,
            child: AppTextStyles.normalText(value, normal, black,
                1), //look for save icon then use a ListTile
          ),
        )
        .toList();
  }

  Widget menuButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, color: black),
      onSelected: (String value) => setState(
        () {
          switch (value) {
            case save:
              {
                //validateSetVars();
                //saveBtn();
                print("Save");
              }
              break;
            case delete:
              {
                //deleteBtn();
                print("Delete");
              }
              break;
            case update:
              {
                //updateBtn();
                print("Update");
              }
              break;
          }
        },
      ),
      itemBuilder: (BuildContext context) => this._dropDownMenuItems,
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

  Widget scheduleDisplay() {
    return UtilWidget.baseCard(
      160,
      Column(
        children: [
          ListTile(
            leading: AppIconsUsed.calendarIcon,
            title: Text(dateReturn(),
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
          ListTile(
            leading: AppIconsUsed.scheduleTime,
            title: Text(timeReturn(),
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis),
          ),
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SetSchedule(widget.onlineOfflineAppBar, userSchedule, isDate);
        },
      ),
    );
  }

  Widget textHolder(String text) {
    return Text(
      text,
      style: AppTextStyles.normalBlack(normal, black),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  bool autoOnline = false, autoAccept = false;

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

/*
  void openBottomSheet(bool heading) {
    _scaffoldKey.currentState.showBottomSheet(
      (ctx) => bottomSheetContent(heading ? setDate() : Text("Time")),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
    );
  }

  Widget bottomSheetContent(Widget content) {
    return UtilWidget.clipRectForApp(
      Container(
        color: AppColors.appBackgroundColor,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            UtilWidget.bottomSheetStickerContent(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  content,
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          //Removing previous text and replacing it with new
                          /*arrivalPromoText.removeAt(index);
                          arrivalPromoText.insert(
                              index, _editingController.text);*/
                          Navigator.pop(context);
                        }),
                        style: UtilWidget.buttonStyle,
                        child:
                            AppTextStyles.normalText("Next", normal, white, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
*/
  bool absorb = false;

  void setAbsorbState(bool state) {
    setState(() {
      absorb = state;
    });
  }

  bool validateSetVars() {
    bool validate = false;

    return true; //validate;
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

  /*Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: UtilWidget.buttonStyle,
          child: Text(
            "Save",
            style: AppTextStyles.normalBlack(normal, white),
          ),
          onPressed: () {
            
          },
        ),
      ),
    );
  }*/
}
