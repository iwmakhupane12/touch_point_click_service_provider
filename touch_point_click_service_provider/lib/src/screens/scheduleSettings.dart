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
        )
      ],
    );
  }

  String dateReturn() {
    return widget.userSchedule != null
        ? "${widget.userSchedule.getStartDate()} - ${widget.userSchedule.getEndDate()}"
        : "Set date";
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
                  onPressed: () => setDateDialog(),
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
                  onPressed: () {},
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

  int _dateRadioValue = 0;

  void setDateDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "How to Set Date",
          style: AppTextStyles.normalBlack(bold, black),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [setDateRangeSingle()],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 0),
            child: Text(
              "Cancel",
              style: AppTextStyles.normalBlack(normal, Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _dateRadioValue),
            child: Text(
              "OK",
              style: AppTextStyles.normalBlack(normal, Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  final String _byRange = "By Range";
  final String _singular = "Singular";

  Widget setDateRangeSingle() {
    return Column(
      children: [
        ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 1,
              groupValue: _dateRadioValue,
              onChanged: (value) {
                setState(() {
                  _dateRadioValue = value;
                });
              },
            ),
          ),
          title: textToCheck(_byRange, normal),
        ),
        ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 2,
              groupValue: _dateRadioValue,
              onChanged: (value) {
                setState(() {
                  _dateRadioValue = value;
                });
              },
            ),
          ),
          title: textToCheck(_singular, normal),
        ),
      ],
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
