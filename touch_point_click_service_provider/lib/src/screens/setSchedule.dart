import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';
import 'package:touch_point_click_service_provider/src/screens/scheduleSettings.dart';

class SetSchedule extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  UserSchedule userSchedule;
  final String setType;

  SetSchedule(this.onlineOfflineAppBar, this.userSchedule, this.setType);

  @override
  _SetScheduleState createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      Column(
        children: [setDate(), nextBtn()],
      ),
      null,
      "Schedule Settings",
      widget.onlineOfflineAppBar,
    );
  }

  int _radioValue = 1;
  final String _byRange = "By Range";
  final String _singular = "Singular";

  Widget setDate() {
    return UtilWidget.baseCard(
      160,
      Column(
        children: [
          textToCheck(
              widget.setType == "date" ? "How to Set Date" : "How to Set Time",
              bold),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
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
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_singular, normal),
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

  void dateRangePicker() {
    DateTime today = DateTime.now();
    showDateRangePicker(
      context: context,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(today.year, today.month, today.day + 31),
    ).then((DateTimeRange value) {
      if (value != null) {
        DateTimeRange _fromRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );
        _fromRange = value;
        final String range =
            '${dateFormated(_fromRange.start)} - ${dateFormated(_fromRange.end)}';

        if (widget.userSchedule != null) {
          widget.userSchedule.setStartDate(dateFormated(_fromRange.start));
          widget.userSchedule.setEndDate(dateFormated(_fromRange.end));
        } else {
          widget.userSchedule = UserSchedule();
          widget.userSchedule.setStartDate(dateFormated(_fromRange.start));
          widget.userSchedule.setEndDate(dateFormated(_fromRange.end));
        }

        save();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(range),
          ),
        );
      }
    });
  }

  String dateFormated(DateTime fromRange) {
    return '${DateFormat.d().format(fromRange)} ${DateFormat.MMM().format(fromRange)} ${DateFormat.y().format(fromRange)}';
  }

  void save() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScheduleSettings(
              onlineOfflineAppBar: widget.onlineOfflineAppBar,
              userSchedule: widget.userSchedule);
        },
      ),
    );
  }

  void dateSingularPicker() {
    showDatePicker(
      context: context,
      errorInvalidText: "",
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    ).then(
      (DateTime value) {
        if (value != null) {
          DateTime _fromDate = DateTime.now();
          _fromDate = value;

          if (widget.userSchedule != null) {
            widget.userSchedule.setStartDate(dateFormated(_fromDate));
            widget.userSchedule.setEndDate(null);
          } else {
            widget.userSchedule = UserSchedule();
            widget.userSchedule.setStartDate(dateFormated(_fromDate));
            widget.userSchedule.setEndDate(null);
          }

          save();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(dateFormated(_fromDate)),
            ),
          );
        }
      },
    );
  }

  void datePicker() {
    _radioValue == 1 ? dateRangePicker() : dateSingularPicker();
  }

  void timePicker() {}

  Widget nextBtn() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ElevatedButton(
          style: UtilWidget.buttonStyle,
          child: Text(
            "Next",
            style: AppTextStyles.normalBlack(normal, white),
          ),
          onPressed: () =>
              widget.setType == "date" ? datePicker() : timePicker(),
        ),
      ),
    );
  }
}
