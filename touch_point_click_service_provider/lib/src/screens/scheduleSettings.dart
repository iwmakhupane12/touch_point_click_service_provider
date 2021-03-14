import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';

import 'package:touch_point_click_service_provider/src/screens/schedules.dart';
import 'package:touch_point_click_service_provider/src/screens/setSchedule.dart';
import 'package:touch_point_click_service_provider/src/screens/toDoList.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

class ScheduleSettings extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final UserSchedule userSchedule;

  ScheduleSettings({@required this.onlineOfflineAppBar, this.userSchedule});

  @override
  _ScheduleSettingsState createState() => _ScheduleSettingsState();
}

class _ScheduleSettingsState extends State<ScheduleSettings> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  String startDate, endDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      display(),
      null,
      "Schedule Settings",
      widget.onlineOfflineAppBar,
    );
  }

  Widget display() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: textHolder("Automations"),
        ),
        settings(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: textHolder("Schedule"),
            ),
            scheduleDisplay(),
            saveButton()
          ],
        ),
      ],
    );
  }

  String dateReturn() {
    return widget.userSchedule != null
        ? "${widget.userSchedule.getStartDate()}${checkEndDate()}"
        : "Set date";
  }

  String checkEndDate() {
    return widget.userSchedule.getEndDate() != null
        ? " - ${widget.userSchedule.getEndDate()}"
        : "";
  }

  String timeReturn() {
    return widget.userSchedule != null
        ? "${widget.userSchedule.getStartTime()} - ${widget.userSchedule.getEndTime()}"
        : "Set time";
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
                  onPressed: () => addRangeScreen("date"),
                  style: UtilWidget.textButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      widget.userSchedule != null ? "Edit Date" : "Set Date",
                      style: AppTextStyles.normalBlack(normal, Colors.blue),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => addRangeScreen("time"),
                  style: UtilWidget.textButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      widget.userSchedule != null ? "Edit Time" : "Set Time",
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

  void addRangeScreen(String setType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SetSchedule(
              widget.onlineOfflineAppBar, widget.userSchedule, setType);
        },
      ),
    );
  }

  Widget textHolder(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text(
        text,
        style: AppTextStyles.normalBlack(normal, black),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  bool _goOnline = false;
  bool _acceptRequests = false;

  Widget settings() {
    return UtilWidget.baseCard(
      150,
      Flex(
        direction: Axis.vertical,
        children: [
          Row(
            children: [
              Container(
                  width: 230, child: textHolder("Go Online Automatically")),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Switch(
                  value: _goOnline,
                  onChanged: (bool value) => setState(
                    () => _goOnline = value,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  width: 230,
                  child: textHolder("Accept Requests Automatically")),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Switch(
                  value: _acceptRequests,
                  onChanged: (bool value) => setState(
                    () => _acceptRequests = value,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
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

  Widget textToCheck(String text, FontWeight fontWeight) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.normalBlack(fontWeight, black),
      ),
    );
  }

  Widget saveButton() {
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
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
